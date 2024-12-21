import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:kriv/pages/home.dart';
import 'dart:io';

import 'package:kriv/utilities/global.dart';
// BLoC Events
abstract class HouseEvent {}

class HouseSubmitEvent extends HouseEvent {
  final Map<String, Object?> houseData;

  HouseSubmitEvent(this.houseData);
}

// BLoC States
abstract class HouseState {}

class HouseInitialState extends HouseState {}

class HouseLoadingState extends HouseState {}

class HouseSubmittedState extends HouseState {}

class HouseErrorState extends HouseState {
  final String message;
  final bool isSessionExpired;
  HouseErrorState(this.message,{this.isSessionExpired = false});
}

// BLoC Class
class HouseBloc extends Bloc<HouseEvent, HouseState> {
  final String authToken;

  HouseBloc(this.authToken) : super(HouseInitialState()) {
    on<HouseSubmitEvent>(_onHouseSubmitEvent);
  }

  Future<void> _onHouseSubmitEvent(
      HouseSubmitEvent event, Emitter<HouseState> emit) async {
    emit(HouseLoadingState());
    try {
      // Create a multipart request
      var request = http.MultipartRequest(
        'POST', 
        Uri.parse(dotenv.env['SERVER_URL']!+'api/houses/')
      );

      // Add authorization header
      request.headers['Authorization'] = authToken;

      // Separate file and non-file fields
      File? imageFile;
      Map<String, String> stringFields = {};

      event.houseData.forEach((key, value) {
        if (value is File) {
          imageFile = value;
        } else {
          stringFields[key] = value.toString();
        }
      });

      // Add string fields
      request.fields.addAll(stringFields);

      // Add image file if exists
      if (imageFile != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'floor_plan', // Adjust to match backend expected field name
          imageFile!.path
        ));
      }

      // Send the request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      print(response.body);
      print(response.statusCode);
      // Check the response
      if (response.statusCode == 201 || response.statusCode == 200) {
        emit(HouseSubmittedState());
      } else {
        globals.accessToken = '';
        await globals.clearSharedPreferences();
        emit(HouseErrorState(
          'Session expired: Kindly login again',
           isSessionExpired: true
        ));
        
      }
    } catch (e) {
      emit(HouseErrorState('Error occurred: $e'));
      
    }
  }
}