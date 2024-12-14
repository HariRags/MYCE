import 'package:bloc/bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


abstract class UpdateEvent {}

class SubmitUpdateEvent extends UpdateEvent {
  final Map<String, String?> userProfile;
  SubmitUpdateEvent(this.userProfile);
}

abstract class UpdateState {}

class UpdateInitial extends UpdateState {}

class UpdateLoading extends UpdateState {}

class UpdateSuccess extends UpdateState {

  final Map<String, dynamic>? userProfile; // Made optional with nullable type

  UpdateSuccess(this.userProfile);
}

class UpdateFailure extends UpdateState {
  final String error;

  UpdateFailure({required this.error});
}



class UpdateBloc extends Bloc<UpdateEvent, UpdateState> {
   final String? authToken;
  UpdateBloc(this.authToken) : super(UpdateInitial()) {
    on<SubmitUpdateEvent>(_onSubmitSignupEvent);
  }

  Future<void> _onSubmitSignupEvent(
    SubmitUpdateEvent event,
    Emitter<UpdateState> emit,
  ) async {
    emit(UpdateLoading());

    try {
      print(event.userProfile);
      String token = (authToken ?? "");
      final response = await http.put(
        Uri.parse(dotenv.env['SERVER_URL']!+'api/auth/user_profile/'),
        headers: {'Content-Type': 'application/json','Authorization':token},
        body: json.encode(event.userProfile),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final userProfile = data['user_profile'] as Map<String, dynamic>?;
        print("hi : $userProfile");
        emit(UpdateSuccess(userProfile!));
      } else {
        emit(UpdateFailure(error: 'Failed to sign up'));
      }
    } catch (e) {
      emit(UpdateFailure(error: e.toString()));
    }
  }
}