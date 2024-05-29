import 'package:flutter/material.dart';
import 'package:kriv/pages/architecture_and_design/architecture_design.dart';
import 'package:kriv/pages/architecture_and_design/interior_design.dart';
import 'package:kriv/pages/execution/commercial.dart';
import 'package:kriv/pages/execution/house.dart';
import 'package:kriv/pages/execution/industrial.dart';
import 'package:kriv/pages/project_management.dart/project.dart';
import 'package:kriv/pages/real_estate/buy.dart';
import 'package:kriv/pages/real_estate/sell.dart';
import 'package:kriv/pages/swimming_pool/swimming_pool.dart';
import 'pages/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MYCE App',
      theme: ThemeData(
        fontFamily:'Poppins',
        
        primarySwatch: Colors.blue,
      ),
      home: const SwimmingPool(),
    );
  }
}

