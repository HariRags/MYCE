import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

// BLoC Events
abstract class SwimmingEvent {}

class SwimmingSubmitEvent extends SwimmingEvent {
  final Map<String, String?> houseData;

  SwimmingSubmitEvent(this.houseData);
}

// BLoC States
abstract class SwimmingState {}

class SwimmingInitialState extends SwimmingState {}

class SwimmingLoadingState extends SwimmingState {}

class SwimmingSubmittedState extends SwimmingState {}

class SwimmingErrorState extends SwimmingState {
  final String message;

  SwimmingErrorState(this.message);
}

// BLoC Class
class SwimmingBloc extends Bloc<SwimmingEvent, SwimmingState> {
  final String authToken;

  SwimmingBloc(this.authToken) : super(SwimmingInitialState()) {
    // Register the event handler for HouseSubmitEvent
    on<SwimmingSubmitEvent>(_onSwimmingSubmitEvent);
  }

  // Event handler for HouseSubmitEvent
  Future<void> _onSwimmingSubmitEvent(
      SwimmingSubmitEvent event, Emitter<SwimmingState> emit) async {
    emit(SwimmingLoadingState());
    try {

      //TO FIX : on the basis of backend model for swimming pool
      print(authToken);
      final response =
          await http.post(Uri.parse('http://10.0.2.2:8000/api/swimming-pool/'),
              headers: {
                'Content-Type': 'application/json',
                'Authorization': authToken,
              },
              body: jsonEncode(event.houseData));
      print(event.houseData);
      if (response.statusCode == 201) {
        emit(SwimmingSubmittedState());
        // Request was successful
      } else {
        emit(SwimmingErrorState('Error : Failed to sign up'));
      }
    } catch (e) {
      emit(SwimmingErrorState('Error occurred: $e')); // Emit error state
    }
  }
}
