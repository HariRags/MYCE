import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kriv/utilities/responsive.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end:Alignment.topCenter,
            colors: [Color.fromRGBO(245, 237, 255, 1),Color.fromRGBO(255, 255, 255, 1)]
          )
        ),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          Container(
            margin: EdgeInsets.only(top:Responsive.height(20, context), bottom: Responsive.height(5, context)),
            child: Image.asset('assets/images/myce_logo.png'),
          ),
          Container(
            margin: EdgeInsets.only(bottom: Responsive.height(2, context)),
            padding: EdgeInsets.only(left:Responsive.width(5, context)),
            alignment: Alignment.centerLeft,
            child: Text('Login or Sign up', style: TextStyle(color:const Color.fromRGBO(49, 49, 49, 1), fontFamily: 'Poppins',fontWeight:FontWeight.w600, fontSize: Responsive.height(2, context)  ),)
            ),
            Container(
              
            margin: EdgeInsets.only(bottom: Responsive.height(2, context)),
              padding: EdgeInsets.only(left:Responsive.width(5, context), right: Responsive.width(15, context)),
              alignment: Alignment.centerLeft,
              child:Text('Enter email or phone number to get one time otp', style: TextStyle(color:const Color.fromRGBO(102, 102, 102, 1), fontFamily: 'Poppins',fontWeight:FontWeight.w500, fontSize: Responsive.height(1.7, context)  ),)
             ,
            ),
            Container(
              margin: EdgeInsets.only(left: Responsive.width(5, context),right: Responsive.width(5, context), bottom: Responsive.height(3, context)),
              padding: EdgeInsets.only(left: Responsive.width(2, context)),
                  height: Responsive.height(5, context),
                  alignment: Alignment.topLeft,
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: const Color.fromRGBO(149, 149, 149, 1)),
                      borderRadius: BorderRadius.circular(6)),
                  child: Form(
                        child: TextFormField(
                          decoration: InputDecoration(
                              hintText: 'Email id or phone number',
                              hintStyle: TextStyle(
                                  color: const Color.fromRGBO(17, 17, 19, 0.6),
                                  fontSize: Responsive.height(1.8, context),
                                  fontWeight: FontWeight.w400,
                                  ),
                              contentPadding: EdgeInsets.only(
                                  left: Responsive.width(1, context),
                                  bottom: Responsive.height(1.2, context)),
                              border: InputBorder.none),
                        ),
                      ),
            ),
            Container(
              margin: EdgeInsets.only(left: Responsive.width(5, context),right: Responsive.width(5, context)),
                width: Responsive.width(95, context),
                height: Responsive.height(6.5, context),
                child: FilledButton(
                  onPressed: () {},
                  child: Text(
                    'Get otp',
                    style: TextStyle(fontSize: Responsive.height(2.3, context)),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      const Color.fromRGBO(107, 67, 151, 1),
                    ),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13))),
                  ),
                ),
              )
         
        ],)
      ),
    );
  }
}
