import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:io';
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

  HouseErrorState(this.message);
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
        Uri.parse('http://10.0.2.2:8000/api/houses/')
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

      // Check the response
      if (response.statusCode == 201) {
        emit(HouseSubmittedState());
      } else {
        emit(HouseErrorState('Enter all the details'));
        print('Response body: ${response.body}');
      }
    } catch (e) {
      emit(HouseErrorState('Error occurred: $e'));
      print('Exception details: $e');
    }
  }
}