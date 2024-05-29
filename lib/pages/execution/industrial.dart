
import 'package:flutter/material.dart';

import 'package:kriv/widgets/myce_backbutton.dart';
import 'package:kriv/widgets/navigation.dart';

import '../../widgets/card.dart';

class Industrial extends StatefulWidget {
  const Industrial({Key? key}) : super(key: key);

  @override
  State <Industrial> createState() =>  IndustrialState();
}

class  IndustrialState extends State <Industrial> {
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const MYCEBackButton(),
            const NavigationWidget(navigationItems: ['Execution', 'Industrial']),
            SingleChildScrollView(
              child: Column(
                children: [
                  InkWell(
                    onTap:(){},
                    child: const ImageCard(
                      title: 'Office Space',
                      description: 'Areas within a building specifically designed for working, typically equipped with desks, computers, and other work-related amenities.',
                      imagePath: 'assets/images/execution/villa.png',)
                      
                  ),
                  InkWell(
                    onTap:(){},
                    child: const ImageCard(
                      title: 'Retail Space',
                      description: 'Commercial areas where goods or services are sold directly to consumers.',
                      imagePath: 'assets/images/execution/bungalow.png',)
                      
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