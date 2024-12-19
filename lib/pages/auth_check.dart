import 'package:flutter/material.dart';
import 'package:kriv/pages/home.dart';
import 'package:kriv/pages/homepage.dart';
import 'package:kriv/utilities/global.dart';

class AuthCheck extends StatelessWidget {
  const AuthCheck({Key? key}) : super(key: key);

  Future<bool> isUserLoggedIn() async {
    await globals.loadFromSharedPreferences();
    print("hey");
    print(globals.accessToken);
    return globals.accessToken.isNotEmpty; // Check if accessToken exists
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: isUserLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.data == true) {
          return const HomePage(); // Navigate to homepage
        } else {
          return const Home(); // Navigate to login page
        }
      },
    );
  }
}
