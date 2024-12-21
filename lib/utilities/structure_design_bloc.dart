import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:kriv/utilities/global.dart';

// Structure BLoC Events
abstract class StructureEvent {}

class StructureSubmitEvent extends StructureEvent {
  final Map<String, String?> structureData;

  StructureSubmitEvent(this.structureData);
}

// Structure BLoC States
abstract class StructureState {}

class StructureInitialState extends StructureState {}

class StructureLoadingState extends StructureState {}

class StructureSubmittedState extends StructureState {}

class StructureErrorState extends StructureState {
  final String message;
  final bool isSessionExpired;
  StructureErrorState(this.message,{this.isSessionExpired=false});
}

// Structure BLoC Class
class StructureBloc extends Bloc<StructureEvent, StructureState> {
  final String authToken;

  StructureBloc(this.authToken) : super(StructureInitialState()) {
    on<StructureSubmitEvent>(_onStructureSubmitEvent);
  }

  Future<void> _onStructureSubmitEvent(
      StructureSubmitEvent event, Emitter<StructureState> emit) async {
    emit(StructureLoadingState());
    try {
      final response = await http.post(
        Uri.parse(dotenv.env['SERVER_URL']!+'api/architecture-design/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': authToken,
        },
        body: jsonEncode(event.structureData),
      );
      
      
      if (response.statusCode == 201) {
        emit(StructureSubmittedState());
      } else {
        globals.accessToken = '';
        await globals.clearSharedPreferences();
        emit(StructureErrorState(
          'Session expired: Kindly login again',
           isSessionExpired: true
        ));
      }
    } catch (e) {
      emit(StructureErrorState('Error occurred: $e'));
    }
  }
}
