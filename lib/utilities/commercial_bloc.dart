import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

// BLoC Events
abstract class CommercialEvent {}

class CommercialSubmitEvent extends CommercialEvent {
  final Map<String, String?> commercialData;

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
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/commercial-properties/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': authToken,
        },
        body: jsonEncode(event.commercialData),
      );
      print((event.commercialData));
      if (response.statusCode == 201) {
        emit(CommercialSubmittedState());
      } else {
        print('Request failed with status: ${response.statusCode}.');
        print('Response body: ${response.body}');
        emit(CommercialErrorState('Error: Failed to submit commercial property data'));
      }
    } catch (e) {
      emit(CommercialErrorState('Error occurred: $e'));
    }
  }
}
