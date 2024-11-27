import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

// BLoC Events
abstract class BuyEvent {}

class BuySubmitEvent extends BuyEvent {
  final Map<String, String?> houseData;

  BuySubmitEvent(this.houseData);
}

// BLoC States
abstract class BuyState {}

class BuyInitialState extends BuyState {}

class BuyLoadingState extends BuyState {}

class BuySubmittedState extends BuyState {}

class BuyErrorState extends BuyState {
  final String message;

  BuyErrorState(this.message);
}

// BLoC Class
class BuyBloc extends Bloc<BuyEvent, BuyState> {
  final String authToken;

  BuyBloc(this.authToken) : super(BuyInitialState()) {
    // Register the event handler for HouseSubmitEvent
    on<BuySubmitEvent>(_onBuySubmitEvent);
  }

  // Event handler for HouseSubmitEvent
  Future<void> _onBuySubmitEvent(
      BuySubmitEvent event, Emitter<BuyState> emit) async {
    emit(BuyLoadingState());
    try {
      print(authToken);
      final response =
          await http.post(Uri.parse('http://10.0.2.2:8000/api/real-estate-buy/'),
              headers: {
                'Content-Type': 'application/json',
                'Authorization': authToken,
              },
              body: jsonEncode(event.houseData));
      print(event.houseData);
      if (response.statusCode == 201) {
        emit(BuySubmittedState());
        // Request was successful
      } else {
        emit(BuyErrorState('Error : Failed to sign up'));
      }
    } catch (e) {
      emit(BuyErrorState('Error occurred: $e')); // Emit error state
    }
  }
}
