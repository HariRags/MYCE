import 'package:flutter/material.dart';
import 'package:kriv/pages/execution/house_villa.dart';
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
      home: const HouseVilla(),
    );
  }
}

