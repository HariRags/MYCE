import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:kriv/utilities/global.dart';

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
  final bool isSessionExpired;
  BuyErrorState(this.message,{this.isSessionExpired=false});
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
      
      final response =
          await http.post(Uri.parse(dotenv.env['SERVER_URL']!+'api/buying-property/'),
              headers: {
                'Content-Type': 'application/json',
                'Authorization': authToken,
              },
              body: jsonEncode(event.houseData));
      
      if (response.statusCode == 201) {
        emit(BuySubmittedState());
        // Request was successful
      } else {
       globals.accessToken = '';
        await globals.clearSharedPreferences();
        emit(BuyErrorState(
          'Session expired: Kindly login again',
           isSessionExpired: true
        ));
      }
    } catch (e) {
      emit(BuyErrorState('Error occurred: $e')); // Emit error state
    }
  }
}
