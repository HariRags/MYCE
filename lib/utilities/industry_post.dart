import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:io';
// BLoC Events
abstract class IndustryEvent {}

class IndustrySubmitEvent extends IndustryEvent {
  final Map<String, Object?> industryData;

  IndustrySubmitEvent(this.industryData);
}

// BLoC States
abstract class IndustryState {}

class IndustryInitialState extends IndustryState {}

class IndustryLoadingState extends IndustryState {}

class IndustrySubmittedState extends IndustryState {}

class IndustryErrorState extends IndustryState {
  final String message;

  IndustryErrorState(this.message);
}

// BLoC Class
class IndustryBloc extends Bloc<IndustryEvent, IndustryState> {
  final String authToken;

  IndustryBloc(this.authToken) : super(IndustryInitialState()) {
    // Register the event handler for IndustrySubmitEvent
    on<IndustrySubmitEvent>(_onIndustrySubmitEvent);
  }

  // Event handler for IndustrySubmitEvent
  Future<void> _onIndustrySubmitEvent(
      IndustrySubmitEvent event, Emitter<IndustryState> emit) async {
    emit(IndustryLoadingState());
    try {
      // 
       var request = http.MultipartRequest(
        'POST', 
        Uri.parse(dotenv.env['SERVER_URL']!+'api/industrial-properties/')
      );

      // Add authorization header
      request.headers['Authorization'] = authToken;

      // Separate file and non-file fields
      File? imageFile;
      Map<String, String> stringFields = {};

      event.industryData.forEach((key, value) {
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

      if (response.statusCode == 201) {
        emit(IndustrySubmittedState());
        // Request was successful
      } else {
        
        
        emit(IndustryErrorState('Enter all the details'));
      }
    } catch (e) {
      emit(IndustryErrorState('Error occurred: $e')); // Emit error state
    }
  }
}
