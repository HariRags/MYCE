import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:kriv/widgets/myce_backbutton.dart';
import 'package:kriv/widgets/navigation.dart';
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
            const MYCEBackButton(),
            const NavigationWidget(navigationItems: ['Execution', 'House']),
            Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    InkWell(
                      onTap:(){},
                      child: Card(
                        margin: EdgeInsets.only(left: Responsive.width(4, context), right: Responsive.width(4, context), bottom: Responsive.height(2, context)),
                        elevation: 6,
                        surfaceTintColor: Colors.white,
                        color: Colors.white,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              
                              margin: EdgeInsets.only(bottom:Responsive.height(1, context),),
                              width: Responsive.width(65, context),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                        padding: EdgeInsets.fromLTRB(
                                          Responsive.width(8, context),
                                          Responsive.height(2.5, context),
                                          Responsive.width(5, context),
                                          0,
                                        ),
                               child:  Text('Villa', style: TextStyle(fontFamily:'Poppins', fontSize: Responsive.height(2.5, context), color: Colors.black, fontWeight: FontWeight.w600, letterSpacing: 0.5),),
                                  ),
                                Padding(
                                  padding:  EdgeInsets.fromLTRB(
                                          Responsive.width(8, context),
                                          0,
                                          Responsive.width(5, context),
                                          Responsive.height(0.6, context),
                                        ),
                                  child: Text('A large and luxurious house, often located in a scenic or desirable area.', style: TextStyle(fontFamily: 'Poppins', color: Color.fromRGBO(81, 81, 81, 1)),),
                                )
                              ],),
                            ),
                           Container(
                            height: Responsive.height(12.5, context),
                             child: Image.asset(
                               'assets/images/villa_pic.png',
                               fit: BoxFit.cover,
                             ),
                           ),
                          ],
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