import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// BLoC Events
abstract class ServicesEvent {}

class ServicesSubmitEvent extends ServicesEvent {
  final Map<String, String?> servicesData;

  ServicesSubmitEvent(this.servicesData);
}

// BLoC States
abstract class ServicesState {}

class ServicesInitialState extends ServicesState {}

class ServicesLoadingState extends ServicesState {}

class ServicesSubmittedState extends ServicesState {}

class ServicesErrorState extends ServicesState {
  final String message;

  ServicesErrorState(this.message);
}

// BLoC Class
class ServicesBloc extends Bloc<ServicesEvent, ServicesState> {
  final String authToken;

  ServicesBloc(this.authToken) : super(ServicesInitialState()) {
    // Register the event handler for ServicesSubmitEvent
    on<ServicesSubmitEvent>(_onServicesSubmitEvent);
  }

  // Event handler for ServicesSubmitEvent
  Future<void> _onServicesSubmitEvent(
      ServicesSubmitEvent event, Emitter<ServicesState> emit) async {
    emit(ServicesLoadingState());
    try {
      print('Sending request with authToken: $authToken');

      final response = await http.post(
        Uri.parse(dotenv.env['SERVER_URL']!+'api/project-management-service/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': authToken,
        },
        body: jsonEncode(event.servicesData),
      );

      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 201) {
        emit(ServicesSubmittedState());
      } else {
        emit(ServicesErrorState('Error: Failed to submit services data.'));
      }
    } catch (e) {
      emit(ServicesErrorState('Error occurred: $e'));
    }
  }
}
