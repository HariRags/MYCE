import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Events
abstract class AuthEvent {}

class VerifyPhoneEvent extends AuthEvent {
  final BigInt? phoneNumber;
  VerifyPhoneEvent(this.phoneNumber);

  @override
  String toString() => 'VerifyPhoneEvent(phoneNumber: $phoneNumber)';
}

// States
abstract class AuthState {}

class AuthInitial extends AuthState {
  @override
  String toString() => 'AuthInitial';
}

class AuthLoading extends AuthState {
  @override
  String toString() => 'AuthLoading';
}

class AuthSuccess extends AuthState {
  final String message;
  AuthSuccess(this.message);

  @override
  String toString() => 'AuthSuccess(message: $message)';
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);

  @override
  String toString() => 'AuthError(message: $message)';
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<VerifyPhoneEvent>((event, emit) async {
      await _onVerifyPhone(event, emit);
    });
  }

  // Add state change observer
  @override
  void onChange(Change<AuthState> change) {
    super.onChange(change);
    print('AuthBloc: State changed from ${change.currentState} to ${change.nextState}');
  }

  // Add event observer
  @override
  void onEvent(AuthEvent event) {
    super.onEvent(event);
    print('AuthBloc: Received event $event');
  }

  // Add transition observer
  @override
  void onTransition(Transition<AuthEvent, AuthState> transition) {
    super.onTransition(transition);
    print('AuthBloc: Transition - Event: ${transition.event}, '
        'CurrentState: ${transition.currentState}, '
        'NextState: ${transition.nextState}');
  }

  Future<void> _onVerifyPhone(
      VerifyPhoneEvent event, Emitter<AuthState> emit) async {
    try {
      print('AuthBloc: Starting phone verification process');
      
      if (event.phoneNumber == null) {
        print('AuthBloc: Phone number is null, emitting error');
        emit(AuthError('Phone number cannot be null'));
        return;
      }

      print('AuthBloc: Emitting loading state');
      emit(AuthLoading());

      print('AuthBloc: Making API call');
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/auth/verify_phone/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'phone_number': event.phoneNumber.toString(),
        }),
      );

      print('AuthBloc: Received API response - Status: ${response.statusCode}');
      print('AuthBloc: Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        if (responseBody.containsKey('success')) {
          final successMessage = responseBody['success'];
          print('AuthBloc: API call successful, emitting success state');
          emit(AuthSuccess(successMessage));
          print('AuthBloc: Success state emitted');
        } else {
          print('AuthBloc: Unexpected response format, emitting error');
          emit(AuthError('Unexpected response format'));
        }
      } else {
        print('AuthBloc: Non-200 status code, emitting error');
        emit(AuthError('Server error: ${response.statusCode}'));
      }
    } catch (e, stackTrace) {
      print('AuthBloc: Exception occurred: $e');
      print('AuthBloc: Stack trace: $stackTrace');
      emit(AuthError('Failed to connect to the server: $e'));
    }
  }
}