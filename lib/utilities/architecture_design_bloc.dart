import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:kriv/utilities/global.dart';

// Architecture BLoC Events
abstract class ArchitectureEvent {}

class ArchitectureSubmitEvent extends ArchitectureEvent {
  final Map<String, String?> architectureData;

  ArchitectureSubmitEvent(this.architectureData);
}

// Architecture BLoC States
abstract class ArchitectureState {}

class ArchitectureInitialState extends ArchitectureState {}

class ArchitectureLoadingState extends ArchitectureState {}

class ArchitectureSubmittedState extends ArchitectureState {}

class ArchitectureErrorState extends ArchitectureState {
  final String message;
  final bool isSessionExpired;
  ArchitectureErrorState(this.message,{this.isSessionExpired=false});
}

// Architecture BLoC Class
class ArchitectureBloc extends Bloc<ArchitectureEvent, ArchitectureState> {
  final String authToken;

  ArchitectureBloc(this.authToken) : super(ArchitectureInitialState()) {
    // Register the event handler for ArchitectureSubmitEvent
    on<ArchitectureSubmitEvent>(_onArchitectureSubmitEvent);
  }

  // Event handler for ArchitectureSubmitEvent
  Future<void> _onArchitectureSubmitEvent(
      ArchitectureSubmitEvent event, Emitter<ArchitectureState> emit) async {
    emit(ArchitectureLoadingState());
    try {
      
      final response = await http.post(
        Uri.parse(dotenv.env['SERVER_URL']!+'api/architecture-design/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': authToken,
        },
        body: jsonEncode(event.architectureData),
      );
      
      if (response.statusCode == 201 || response.statusCode == 200) {
        emit(ArchitectureSubmittedState());
      } else {
        globals.accessToken = '';
        await globals.clearSharedPreferences();
        emit(ArchitectureErrorState(
          'Session expired: Kindly login again',
           isSessionExpired: true
        ));
      }
    } catch (e) {
      emit(ArchitectureErrorState('Error occurred: $e'));
    }
  }
}
