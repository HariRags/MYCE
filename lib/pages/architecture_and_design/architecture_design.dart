
import 'package:flutter/material.dart';
import 'package:kriv/utilities/responsive.dart';

import 'package:kriv/widgets/myce_backbutton.dart';
import 'package:kriv/widgets/navigation.dart';

import '../../widgets/card.dart';

class ArchitectureDesign extends StatefulWidget {
  const ArchitectureDesign({Key? key}) : super(key: key);

  @override
  State <ArchitectureDesign> createState() =>  ArchitectureDesignState();
}

class  ArchitectureDesignState extends State <ArchitectureDesign> {
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const MYCEBackButton(),
            const NavigationWidget(navigationItems: ['Architecture & Design', 'Architecture Design']),
            Container(
              height: Responsive.height(80, context),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    InkWell(
                      onTap:(){},
                      child: const ImageCard(
                        title: 'Villa',
                        description: 'Planning and creating the layout, appearance, and functionality of a luxury house.',
                        imagePath: 'assets/images/execution/villa.png',)
                        
                    ),
                    InkWell(
                      onTap:(){},
                      child: const ImageCard(
                        title: 'Bungalow',
                        description: 'Planning and creating the layout, appearance, and functionality of a single-story house.',
                        imagePath: 'assets/images/execution/bungalow.png',)
                        
                    ),
                    InkWell(
                      onTap:(){},
                      child: const ImageCard(
                        title: 'Farmhouse',
                        description: 'Planning and creating the layout, appearance, and functionality of a rural residential building typically surrounded by agricultural land.',
                        imagePath: 'assets/images/execution/farmhouse.png',)
                        
                    ),
                    InkWell(
                      onTap:(){},
                      child: const ImageCard(
                        title: 'Residential Apartment',
                        description: 'Planning and creating the layout, appearance, and functionality of a housing unit within a multi-story building.',
                        imagePath: 'assets/images/execution/apartment.png',)
                        
                    ),
                    InkWell(
                      onTap:(){},
                      child: const ImageCard(
                        title: 'Commercial',
                        description: 'Planning and creating the layout, appearance, and functionality of areas used for conducting business activities or providing services.',
                        imagePath: 'assets/images/execution/apartment.png',)
                        
                    ),
                    InkWell(
                      onTap:(){},
                      child: const ImageCard(
                        title: 'Industrial',
                        description: 'Planning and creating the layout, appearance, and functionality of areas used for manufacturing, production, or storage of goods.',
                        imagePath: 'assets/images/execution/apartment.png',)
                        
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