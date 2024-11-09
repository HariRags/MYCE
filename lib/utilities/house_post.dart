import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

// BLoC Events
abstract class HouseEvent {}

class HouseSubmitEvent extends HouseEvent {
  final Map<String, String?> houseData;

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
    // Register the event handler for HouseSubmitEvent
    on<HouseSubmitEvent>(_onHouseSubmitEvent);
  }

  // Event handler for HouseSubmitEvent
  Future<void> _onHouseSubmitEvent(
      HouseSubmitEvent event, Emitter<HouseState> emit) async {
    emit(HouseLoadingState());
    try {
      print('hey3');
      print(authToken);
      print('hey3');
      final response =
          await http.post(Uri.parse('http://10.0.2.2:8000/api/houses/'),
              headers: {
                'Content-Type': 'application/json',
                'Authorization': authToken,
              },
              body: jsonEncode(event.houseData));

      if (response.statusCode == 201) {
        emit(HouseSubmittedState());
        // Request was successful
      } else {
        emit(HouseErrorState('Error : Failed to sign up'));
      }
    } catch (e) {
      emit(HouseErrorState('Error occurred: $e')); // Emit error state
    }
  }
}
