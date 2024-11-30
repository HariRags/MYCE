import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:io';
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

  SellErrorState(this.message);
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
      print(event.houseData);
      var request = http.MultipartRequest(
        'POST', 
        Uri.parse('http://10.0.2.2:8000/api/selling-property/')
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

      if (response.statusCode == 201) {
        emit(SellSubmittedState());
        // Request was successful
      } else {
        emit(SellErrorState('Error : Failed to sign up'));
      }
    } catch (e) {
      emit(SellErrorState('Error occurred: $e')); // Emit error state
    }
  }
}
