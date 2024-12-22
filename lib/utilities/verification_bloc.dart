import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
  final bool registered;
  VerificationSuccess(this.accessToken, this.refreshToken, this.userProfile, this.registered);
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
      
      
      late final response;
      if(event.input['email']==null&&event.input['phone_number']==null){
      
      emit(VerificationError('An error occurred during verification. Please try again.'));
      }else{
      if (event.input['email'] != null) {
          response = await http.post(
            Uri.parse(dotenv.env['SERVER_URL']!+'api/auth/verify_otp/'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'otp': event.otp,
              'email': event.input['email'] ?? '',
            }),
          );
        } else{
          response = await http.post(
            Uri.parse(dotenv.env['SERVER_URL']!+'api/auth/verify_otp/'),
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
        

      final responseData = data['data'] as Map<String, dynamic>?; // Extract the 'data' map
      final accessToken = responseData?['access'] as String?;
      final refreshToken = responseData?['refresh'] as String?;
      final userProfile = responseData?['user_profile'] as Map<String, dynamic>?;
      final registered = responseData?['registered'] as bool;

        if (accessToken == null || refreshToken == null) {
          throw FormatException('Missing access or refresh token in response');
        }

        emit(VerificationSuccess(
          accessToken,
          refreshToken,
          userProfile,
          registered // This can be null now
        ));
      } else {
        final errorBody = jsonDecode(response.body) as Map<String, dynamic>;
        final errorMessage = errorBody['detail'] ?? 'Verification failed';
        emit(VerificationError(errorMessage.toString()));
      }
    } on FormatException catch (e) {
      emit(VerificationError('Incorrect OTP'));
    } catch (e) {
      
      emit(VerificationError('An error occurred during verification. Please try again.'));
    }
  }
}