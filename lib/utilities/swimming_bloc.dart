import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:kriv/utilities/global.dart';

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
  final bool isSessionExpired;
  SwimmingErrorState(this.message,{this.isSessionExpired=false});
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
      
      final response =
          await http.post(Uri.parse(dotenv.env['SERVER_URL']!+'api/swimming_pool/'),
              headers: {
                'Content-Type': 'application/json',
                'Authorization': authToken,
              },
              body: jsonEncode(event.houseData));
      
      if (response.statusCode == 200) {
        emit(SwimmingSubmittedState());
        // Request was successful
      } else {
       globals.accessToken = '';
        await globals.clearSharedPreferences();
        emit(SwimmingErrorState(
          'Session expired: Kindly login again',
           isSessionExpired: true
        ));
      }
    } catch (e) {
      emit(SwimmingErrorState('Error occurred: $e')); // Emit error state
    }
  }
}
