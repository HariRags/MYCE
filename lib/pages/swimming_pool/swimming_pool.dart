
import 'package:flutter/material.dart';
import 'package:kriv/utilities/responsive.dart';

import 'package:kriv/widgets/myce_backbutton.dart';
import 'package:kriv/widgets/navigation.dart';

import '../../widgets/card.dart';

class SwimmingPool extends StatefulWidget {
  const SwimmingPool({Key? key}) : super(key: key);

  @override
  State <SwimmingPool> createState() =>  SwimmingPoolState();
}

class  SwimmingPoolState extends State <SwimmingPool> {
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const MYCEBackButton(),
            const NavigationWidget(navigationItems: ['Swimming Pool']),
            Container(
              height: Responsive.height(80, context),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    InkWell(
                      onTap:(){},
                      child: const ImageCard(
                        title: 'Execution ',
                        description: 'This involves the physical construction and installation of the pool based on the design plans.',
                        imagePath: 'assets/images/execution/villa.png',)
                        
                    ),
                    InkWell(
                      onTap:(){},
                      child: const ImageCard(
                        title: 'Maintenance',
                        description: 'This involves cleaning, repairing, and ensuring the proper functioning of the pool and its equipment.',
                        imagePath: 'assets/images/execution/bungalow.png',)
                        
                    ),
                    InkWell(
                      onTap:(){},
                      child: const ImageCard(
                        title: 'Equipments',
                        description: 'The devices and machinery used for filtration, circulation, heating, and maintenance of the pool water.',
                        imagePath: 'assets/images/execution/farmhouse.png',)
                        
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