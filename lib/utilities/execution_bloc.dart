import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

// BLoC Events
abstract class ExecutionEvent {}

class ExecutionSubmitEvent extends ExecutionEvent {
  final Map<String, String?> houseData;

  ExecutionSubmitEvent(this.houseData);
}

// BLoC States
abstract class ExecutionState {}

class ExecutionInitialState extends ExecutionState {}

class ExecutionLoadingState extends ExecutionState {}

class ExecutionSubmittedState extends ExecutionState {}

class ExecutionErrorState extends ExecutionState {
  final String message;

  ExecutionErrorState(this.message);
}

// BLoC Class
class ExecutionBloc extends Bloc<ExecutionEvent, ExecutionState> {
  final String authToken;

  ExecutionBloc(this.authToken) : super(ExecutionInitialState()) {
    // Register the event handler for HouseSubmitEvent
    on<ExecutionSubmitEvent>(_onExecutionSubmitEvent);
  }

  // Event handler for HouseSubmitEvent
  Future<void> _onExecutionSubmitEvent(
      ExecutionSubmitEvent event, Emitter<ExecutionState> emit) async {
    emit(ExecutionLoadingState());
    try {
      print('hey3');
      print(authToken);
      print('hey3');
      final response =
          await http.post(Uri.parse(dotenv.env['SERVER_URL']!+'api/execution-phase/'),
              headers: {
                'Content-Type': 'application/json',
                'Authorization': authToken,
              },
              body: jsonEncode(event.houseData));
      print(event.houseData);
      if (response.statusCode == 201) {
        emit(ExecutionSubmittedState());
        // Request was successful
      } else {
        emit(ExecutionErrorState('Error : Failed to sign up'));
      }
    } catch (e) {
      emit(ExecutionErrorState('Error occurred: $e')); // Emit error state
    }
  }
}
