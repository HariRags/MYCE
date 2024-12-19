import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// BLoC Events
abstract class ContactEvent {}

class ContactSubmitEvent extends ContactEvent {
  final Map<String, String?> commercialData;

  ContactSubmitEvent(this.commercialData);
}

// BLoC States
abstract class ContactState {}

class ContactInitialState extends ContactState {}

class ContactLoadingState extends ContactState {}

class ContactSubmittedState extends ContactState {}

class ContactErrorState extends ContactState {
  final String message;

  ContactErrorState(this.message);
}

// BLoC Class
class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final String authToken;

  ContactBloc(this.authToken) : super(ContactInitialState()) {
    // Register the event handler for CommercialSubmitEvent
    on<ContactSubmitEvent>(_onContactSubmitEvent);
  }

  // Event handler for CommercialSubmitEvent
  Future<void> _onContactSubmitEvent(
      ContactSubmitEvent event, Emitter<ContactState> emit) async {
    emit(ContactLoadingState());
    try {
      final response = await http.post(
        Uri.parse(dotenv.env['SERVER_URL']!+'api/inquiries/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': authToken,
        },
        body: jsonEncode(event.commercialData),
      );
      
      if (response.statusCode == 201) {
        
        emit(ContactSubmittedState());
      } else {
        
        
        emit(ContactErrorState('Error: Failed to submit the data'));
      }
    } catch (e) {
      emit(ContactErrorState('Error occurred: $e'));
    }
  }
}
