import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Events
abstract class AuthEvent {}

class VerifyPhoneEvent extends AuthEvent {
  final Map<String,String?> input;
  VerifyPhoneEvent(this.input);
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
    
  }

  // Add event observer
  @override
  void onEvent(AuthEvent event) {
    super.onEvent(event);
    
  }

  // Add transition observer
  @override
  void onTransition(Transition<AuthEvent, AuthState> transition) {
    super.onTransition(transition);
    
       
  }

  Future<void> _onVerifyPhone(
      VerifyPhoneEvent event, Emitter<AuthState> emit) async {
    try {
      
      
      // if (event.input == null) {
      //   
      //   emit(AuthError('Input cannot be null'));
      //   return;
      // }

      
      emit(AuthLoading());
      late final response;
      
      
      
      if(event.input['email']==null && event.input['phone_number']==null){
        
          emit(AuthError('Incorrect Format'));
          return;
      }else{
        if(event.input['email']!=null){
          
       response = await http.post(
          Uri.parse(dotenv.env['SERVER_URL']!+'api/auth/verify_email/'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'email': event.input['email'],
          }),
        );
      }else{
          response = await http.post(
          Uri.parse(dotenv.env['SERVER_URL']!+'api/auth/verify_phone/'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'phone_number': event.input['phone_number'],
          }),
        );
      }
      }
       

      
      

      if (response.statusCode == 200 ) {
        final responseBody = jsonDecode(response.body);
        if (responseBody.containsKey('success')) {
          final successMessage = responseBody['success'];
          
          emit(AuthSuccess(successMessage));
          
        } else {
          
          emit(AuthError('Unexpected response format'));
        }
      }else if ( response.statusCode == 404) {
        final responseBody = jsonDecode(response.body);
        if (responseBody.containsKey('msg')) {
          final successMessage = responseBody['msg'];
          
          emit(AuthSuccess(successMessage));
          
        } else {
          
          emit(AuthError('Error: Failed to login/signup'));
        }
      } 
      else {
        
        emit(AuthError('Server error: ${response.statusCode}'));
      }
    } catch (e, stackTrace) {
      
      
      emit(AuthError('Failed to connect to the server: $e'));
    }
  }
}