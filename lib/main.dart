import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kriv/pages/architecture_and_design/structure_villa.dart';
import 'package:kriv/pages/auth_check.dart';
import 'package:kriv/pages/confirmation.dart';
import 'package:kriv/pages/execution/house_villa.dart';
import 'package:kriv/pages/home.dart';
import 'package:kriv/pages/login/info_page.dart';
import 'package:kriv/pages/login/login.dart';
import 'package:kriv/pages/login/verification.dart';
import 'package:kriv/pages/project_management/services.dart';
import 'package:kriv/pages/real_estate/buy_land.dart';
import 'package:kriv/pages/real_estate/sell_land.dart';
import 'package:kriv/pages/swimming_pool/pool_execution.dart';
import 'package:kriv/pages/swimming_pool/swimming_pool.dart';
import 'package:kriv/utilities/global.dart';
import 'package:kriv/utilities/maps.dart';
import 'pages/homepage.dart';
import 'package:kriv/utilities/login_post.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
void main() async{
  dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized(); // Ensure bindings are initialized
  await globals.loadFromSharedPreferences(); // Load stored data into Globals
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: MaterialApp(
        title: 'MYCE App',
        theme: ThemeData(
          fontFamily:'Poppins',
          
          primarySwatch: Colors.purple,
        ),
        home:  const AuthCheck(),
      ),
    );
  }
}

