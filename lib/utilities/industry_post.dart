import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

// BLoC Events
abstract class IndustryEvent {}

class IndustrySubmitEvent extends IndustryEvent {
  final Map<String, String?> industryData;

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
      print(authToken);
      final response =
          await http.post(Uri.parse('http://10.0.2.2:8000/api/industrial-properties/'),
              headers: {
                'Content-Type': 'application/json',
                'Authorization': authToken,
              },
              body: jsonEncode(event.industryData));

      if (response.statusCode == 201) {
        emit(IndustrySubmittedState());
        // Request was successful
      } else {
        print('Request failed with status: ${response.statusCode}.');
        print('Response body: ${response.body}');
        emit(IndustryErrorState('Error : Failed to sign up'));
      }
    } catch (e) {
      emit(IndustryErrorState('Error occurred: $e')); // Emit error state
    }
  }
}
