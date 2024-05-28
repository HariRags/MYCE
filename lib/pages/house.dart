
import 'package:flutter/material.dart';

import 'package:kriv/widgets/myce_backbutton.dart';
import 'package:kriv/widgets/navigation.dart';

import '../widgets/card.dart';

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
            SingleChildScrollView(
              child: Column(
                children: [
                  InkWell(
                    onTap:(){},
                    child: const ImageCard(
                      title: 'Villa',
                      description: 'A large and luxurious house, often located in a scenic or desirableuiui area.',
                      imagePath: 'assets/images/villa_pic.png',)
                      
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}