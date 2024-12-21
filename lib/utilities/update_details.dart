import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:kriv/utilities/global.dart';


abstract class UpdateEvent {}

class SubmitUpdateEvent extends UpdateEvent {
  final Map<String, Object?> userProfile;
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
  final bool isSessionExpired;
  UpdateFailure(this.error,{this.isSessionExpired=false});
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
  print(authToken);
    try {
      var request = http.MultipartRequest(
        'PUT', 
        Uri.parse(dotenv.env['SERVER_URL']!+'api/auth/user_profile/')
      );

      // Add authorization header
      request.headers['Authorization'] = authToken!;

      // Separate file and non-file fields
      File? imageFile;
      Map<String, String> stringFields = {};

      event.userProfile.forEach((key, value) {
        if (value is File) {
          imageFile = value;
          globals.setProfileImage(imageFile);
        } else {
          stringFields[key] = value.toString();
        }
      });

      // Add string fields
      request.fields.addAll(stringFields);

      // Add image file if exists
      if (imageFile != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'profile_picture', // Adjust to match backend expected field name
          imageFile!.path
        ));
      }

      // Send the request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final userProfile = data['user_profile'] as Map<String, dynamic>?;
        
        emit(UpdateSuccess(userProfile!));
      } else {
         globals.accessToken = '';
        await globals.clearSharedPreferences();
        emit(UpdateFailure(
          'Session expired: Kindly login again',
           isSessionExpired: true
        ));
      }
    } catch (e) {
      globals.setProfileImage(null);
      emit(UpdateFailure("error: "+ e.toString()));
    }
  }
}