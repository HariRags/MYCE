import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:io';

// BLoC Events
abstract class CommercialEvent {}

class CommercialSubmitEvent extends CommercialEvent {
  final Map<String, Object?> commercialData;

  CommercialSubmitEvent(this.commercialData);
}

// BLoC States
abstract class CommercialPropState {}

class CommercialInitialState extends CommercialPropState {}

class CommercialLoadingState extends CommercialPropState {}

class CommercialSubmittedState extends CommercialPropState {}

class CommercialErrorState extends CommercialPropState {
  final String message;

  CommercialErrorState(this.message);
}

// BLoC Class
class CommercialBloc extends Bloc<CommercialEvent, CommercialPropState> {
  final String authToken;

  CommercialBloc(this.authToken) : super(CommercialInitialState()) {
    // Register the event handler for CommercialSubmitEvent
    on<CommercialSubmitEvent>(_onCommercialSubmitEvent);
  }

  // Event handler for CommercialSubmitEvent
  Future<void> _onCommercialSubmitEvent(
      CommercialSubmitEvent event, Emitter<CommercialPropState> emit) async {
    emit(CommercialLoadingState());
    try {
       var request = http.MultipartRequest(
        'POST', 
        Uri.parse('http://10.0.2.2:8000/api/commercial-properties/')
      );

      // Add authorization header
      request.headers['Authorization'] = authToken;

      // Separate file and non-file fields
      File? imageFile;
      Map<String, String> stringFields = {};

      event.commercialData.forEach((key, value) {
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
      print((event.commercialData));
      if (response.statusCode == 201) {
        emit(CommercialSubmittedState());
      } else {
        print('Request failed with status: ${response.statusCode}.');
        print('Response body: ${response.body}');
        emit(CommercialErrorState('Details not filled completely'));
      }
    } catch (e) {
      emit(CommercialErrorState('Error occurred: $e'));
    }
  }
}
