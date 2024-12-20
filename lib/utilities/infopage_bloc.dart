import 'package:bloc/bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


abstract class SignupEvent {}

class SubmitSignupEvent extends SignupEvent {
  final Map<String, String?> userProfile;
  SubmitSignupEvent(this.userProfile);
}

abstract class SignupState {}

class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {}

class SignupSuccess extends SignupState {}

class SignupFailure extends SignupState {
  final String error;

  SignupFailure({required this.error});
}



class SignupBloc extends Bloc<SignupEvent, SignupState> {
   final String? authToken;
  SignupBloc(this.authToken) : super(SignupInitial()) {
    on<SubmitSignupEvent>(_onSubmitSignupEvent);
  }

  Future<void> _onSubmitSignupEvent(
    SubmitSignupEvent event,
    Emitter<SignupState> emit,
  ) async {
    emit(SignupLoading());

    try {
      
      String token = (authToken ?? "");
      final response = await http.post(
        Uri.parse(dotenv.env['SERVER_URL']!+'api/auth/signup/'),
        headers: {'Content-Type': 'application/json','Authorization':token},
        body: json.encode(event.userProfile),
      );
      
      if (response.statusCode == 201 ) {
        emit(SignupSuccess());
      } else {
        emit(SignupFailure(error: 'Failed to sign up'));
      }
    } catch (e) {
      emit(SignupFailure(error: e.toString()));
    }
  }
}