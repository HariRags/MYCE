import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import '../utilities/responsive.dart';
import '../widgets/folders.dart';

class House extends StatefulWidget {
  const House({Key? key}) : super(key: key);

  @override
  State <House> createState() =>  HouseState();
}

class  HouseState extends State <House> {
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left:Responsive.width(3.5, context), bottom: Responsive.height(1, context),),
              child: Row(
                children: [
                  IconButton(
                    icon:  Icon(Icons.arrow_back_ios, size: Responsive.height(2.4, context)),
                    color: Colors.black,
                    visualDensity: VisualDensity.compact,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  GestureDetector(
                                    child: Image.asset('assets/images/myce_back_icon.png'),
                                    onTap: () {
                      Navigator.pop(context);
                    },
                                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left:Responsive.width(3.5, context), bottom: Responsive.height(1.5, context),),
              child: Row(
                children: [
                  Text('Execution', style: TextStyle(fontFamily:'Fraunces', fontSize: Responsive.height(2.1, context), color: Colors.grey),),
                  SizedBox(width: Responsive.width(4, context),),
                  Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey, size: Responsive.height(1.7, context),),
                  SizedBox(width: Responsive.width(4, context),),
                  Text('House', style: TextStyle(fontFamily:'Fraunces', fontSize: Responsive.height(3, context), color: Colors.black),),
                ],
              ) ,
            ),
            Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    InkWell(
                      onTap:(){},
                      child: Card(
                        elevation: 6,
                        surfaceTintColor: Colors.white,
                        color: Colors.white,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(Responsive.width(7,context), Responsive.height(2, context), Responsive.width(5, context), Responsive.height(2, context)),
                          height: Responsive.height(13, context),
                          width: Responsive.width(90, context),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            Text('Villa', style: TextStyle(fontFamily:'Poppins', fontSize: Responsive.height(2.5, context), color: Colors.black, fontWeight: FontWeight.w500, letterSpacing: 0.5),),
                            SizedBox(height: Responsive.height(0.4, context),),
                            Text('A large and luxurious house, often located in a scenic or desirable area.', style: TextStyle(fontFamily: 'Poppins', color: Color.fromRGBO(81, 81, 81, 1)),)
                          ],),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}