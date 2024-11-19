import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  StructureErrorState(this.message);
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
        Uri.parse('http://10.0.2.2:8000/api/structure-design/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
        body: jsonEncode(event.structureData),
      );

      if (response.statusCode == 201) {
        emit(StructureSubmittedState());
      } else {
        emit(StructureErrorState(
            'Error: Failed to submit structure design data.'));
      }
    } catch (e) {
      emit(StructureErrorState('Error occurred: $e'));
    }
  }
}
