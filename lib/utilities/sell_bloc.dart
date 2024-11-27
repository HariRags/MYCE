import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

// BLoC Events
abstract class SellEvent {}

class SellSubmitEvent extends SellEvent {
  final Map<String, String?> houseData;

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
      print(authToken);
      final response =
          await http.post(Uri.parse('http://10.0.2.2:8000/api/real-estate-sell/'),
              headers: {
                'Content-Type': 'application/json',
                'Authorization': authToken,
              },
              body: jsonEncode(event.houseData));
      print(event.houseData);
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
