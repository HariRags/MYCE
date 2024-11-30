import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;

abstract class VerificationEvent {}

class VerifyOtpEvent extends VerificationEvent {
  final Map<String,String?> input;
  final String otp;
  VerifyOtpEvent(this.otp, this.input);
}

abstract class VerificationState {}

class VerificationInitial extends VerificationState {}

class VerificationLoading extends VerificationState {}

class VerificationSuccess extends VerificationState {
  final String accessToken;
  final String refreshToken;
  final Map<String, dynamic>? userProfile; // Made optional with nullable type

  VerificationSuccess(this.accessToken, this.refreshToken, this.userProfile);
}

class VerificationError extends VerificationState {
  final String message;

  VerificationError(this.message);
}

class VerificationBloc extends Bloc<VerificationEvent, VerificationState> {
  VerificationBloc() : super(VerificationInitial()) {
    on<VerifyOtpEvent>(_handleVerifyOtp);
  }

  Future<void> _handleVerifyOtp(
    VerifyOtpEvent event,
    Emitter<VerificationState> emit,
  ) async {
    emit(VerificationLoading());
    
    try {
      print('OTP: ${event.otp}');
      print('Phone Number: ${event.input}');
      late final response;
      if(event.input['email']==null&&event.input['phone_number']==null){
      
      emit(VerificationError('An error occurred during verification. Please try again.'));
      }else{
      if (event.input['email'] != null) {
          response = await http.post(
            Uri.parse('http://10.0.2.2:8000/api/auth/verify_otp/'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'otp': event.otp,
              'email': event.input['email'] ?? '',
            }),
          );
        } else{
          response = await http.post(
            Uri.parse('http://10.0.2.2:8000/api/auth/verify_otp/'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'otp': event.otp,
              'phone_number': event.input['phone_number'] ?? '',
            }),
          );
        }
      }

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        print('Response data: $data');

      final responseData = data['data'] as Map<String, dynamic>?; // Extract the 'data' map
      final accessToken = responseData?['access'] as String?;
      final refreshToken = responseData?['refresh'] as String?;
      final userProfile = responseData?['user_profile'] as Map<String, dynamic>?;

        if (accessToken == null || refreshToken == null) {
          throw FormatException('Missing access or refresh token in response');
        }

        emit(VerificationSuccess(
          accessToken,
          refreshToken,
          userProfile, // This can be null now
        ));
      } else {
        final errorBody = jsonDecode(response.body) as Map<String, dynamic>;
        final errorMessage = errorBody['detail'] ?? 'Verification failed';
        emit(VerificationError(errorMessage.toString()));
      }
    } on FormatException catch (e) {
      emit(VerificationError('Invalid response format: ${e.message}'));
    } catch (e) {
      print('Error during verification: $e');
      emit(VerificationError('An error occurred during verification. Please try again.'));
    }
  }
}