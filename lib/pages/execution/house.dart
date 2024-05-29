
import 'package:flutter/material.dart';

import 'package:kriv/widgets/myce_backbutton.dart';
import 'package:kriv/widgets/navigation.dart';

import '../../widgets/card.dart';

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
                      description: 'A large and luxurious house, often located in a scenic or desirable area.',
                      imagePath: 'assets/images/execution/villa.png',)
                      
                  ),
                  InkWell(
                    onTap:(){},
                    child: const ImageCard(
                      title: 'Bungalow',
                      description: 'A small, single-story house, often with a veranda.',
                      imagePath: 'assets/images/execution/bungalow.png',)
                      
                  ),
                  InkWell(
                    onTap:(){},
                    child: const ImageCard(
                      title: 'Farmhouse',
                      description: 'A house typically located in a rural or agricultural area, used as a residence and often surrounded by farmland.',
                      imagePath: 'assets/images/execution/farmhouse.png',)
                      
                  ),
                  InkWell(
                    onTap:(){},
                    child: const ImageCard(
                      title: 'Apartment',
                      description: 'A self-contained housing unit within a larger building, often part of a residential complex.',
                      imagePath: 'assets/images/execution/apartment.png',)
                      
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