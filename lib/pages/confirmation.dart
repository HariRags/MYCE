// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:kriv/pages/homepage.dart';
import 'package:kriv/utilities/responsive.dart';

class Confirmation extends StatelessWidget {
  const Confirmation({Key? key}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    final String authToken = ModalRoute.of(context)?.settings.arguments as String;
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage(),
        settings: RouteSettings(arguments: authToken)
        ),
      );
    });
    
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Container(
              padding: EdgeInsets.fromLTRB(Responsive.width(10, context), Responsive.height(5, context), 0, 0),
              child: Image.asset('assets/images/myce_back_icon.png')),
              SizedBox(
                height: Responsive.height(33, context),
              ),
              Container(
                alignment: Alignment.center,
                height:Responsive.height(20, context),
                padding: EdgeInsets.only(bottom:Responsive.height(2, context)),
                child: Image.asset('assets/images/engineer.png'),
              ),
              Container(
                alignment: Alignment.center,
                child: Text('Our engineer will \ncontact you Soon!', style: TextStyle(color: Colors.black, fontSize: Responsive.height(2.3, context), fontFamily: 'Poppins',fontWeight: FontWeight.w400),))
          ],
        ),
      ),
    );
  }
}