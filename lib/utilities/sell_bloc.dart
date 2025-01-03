// import 'dart:js_interop';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:kriv/utilities/global.dart';
// BLoC Events
abstract class SellEvent {}

class SellSubmitEvent extends SellEvent {
  final Map<String, Object?> houseData;

  SellSubmitEvent(this.houseData);
}

// BLoC States
abstract class SellState {}

class SellInitialState extends SellState {}

class SellLoadingState extends SellState {}

class SellSubmittedState extends SellState {}

class SellErrorState extends SellState {
  final String message;
  final bool isSessionExpired;
  SellErrorState(this.message,{this.isSessionExpired=false});
}

// BLoC Class
class SellBloc extends Bloc<SellEvent, SellState> {
  final String authToken;

  SellBloc(this.authToken) : super(SellInitialState()) {
    // Register the event handler for HouseSubmitEvent
    on<SellSubmitEvent>(_onSellSubmitEvent);
  }

  // Event handler for HouseSubmitEvent
  Future<void> _onSellSubmitEvent(
      SellSubmitEvent event, Emitter<SellState> emit) async {
    emit(SellLoadingState());
    try {
      
      var request = http.MultipartRequest(
        'POST', 
        Uri.parse(dotenv.env['SERVER_URL']!+'api/selling-property/')
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

      if (response.statusCode == 201||response.statusCode == 200) {
        emit(SellSubmittedState());
        // Request was successful
      } else {
        globals.accessToken = '';
        await globals.clearSharedPreferences();
        emit(SellErrorState(
          'Session expired: Kindly login again',
           isSessionExpired: true
        ));
      }
    } catch (e) {
      emit(SellErrorState('Error occurred: $e')); // Emit error state
    }
  }
}
