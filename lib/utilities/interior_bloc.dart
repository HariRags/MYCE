import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:kriv/utilities/global.dart';

// Interior BLoC Events
abstract class InteriorEvent {}

class InteriorSubmitEvent extends InteriorEvent {
  final Map<String, String?> interiorData;

  InteriorSubmitEvent(this.interiorData);
}

// Interior BLoC States
abstract class InteriorState {}

class InteriorInitialState extends InteriorState {}

class InteriorLoadingState extends InteriorState {}

class InteriorSubmittedState extends InteriorState {}

class InteriorErrorState extends InteriorState {
  final String message;
  final bool isSessionExpired;
  InteriorErrorState(this.message,{this.isSessionExpired=false});
}

// Interior BLoC Class
class InteriorBloc extends Bloc<InteriorEvent, InteriorState> {
  final String authToken;

  InteriorBloc(this.authToken) : super(InteriorInitialState()) {
    on<InteriorSubmitEvent>(_onInteriorSubmitEvent);
  }

  Future<void> _onInteriorSubmitEvent(
      InteriorSubmitEvent event, Emitter<InteriorState> emit) async {
    emit(InteriorLoadingState());
    try {
      final response = await http.post(
        Uri.parse(dotenv.env['SERVER_URL']!+'api/architecture-design/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': authToken,
        },
        body: jsonEncode(event.interiorData),
      );

      if (response.statusCode == 201) {
        emit(InteriorSubmittedState());
      } else {
        globals.accessToken = '';
        await globals.clearSharedPreferences();
        emit(InteriorErrorState(
          'Session expired: Kindly login again',
           isSessionExpired: true
        ));
      }
    } catch (e) {
      emit(InteriorErrorState('Error occurred: $e'));
    }
  }
}
