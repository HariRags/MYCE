
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kriv/pages/architecture_and_design/interior_bungalow.dart';
import 'package:kriv/pages/architecture_and_design/interior_commercial.dart';
import 'package:kriv/pages/architecture_and_design/interior_farmhouse.dart';
import 'package:kriv/pages/architecture_and_design/interior_industrial.dart';
import 'package:kriv/pages/architecture_and_design/interior_residential.dart';
import 'package:kriv/pages/architecture_and_design/interior_villa.dart';
import 'package:kriv/utilities/responsive.dart';

import 'package:kriv/widgets/myce_backbutton.dart';
import 'package:kriv/widgets/navigation.dart';

import '../../widgets/card.dart';

class InteriorDesign extends StatefulWidget {
  const InteriorDesign({Key? key}) : super(key: key);

  @override
  State <InteriorDesign> createState() =>  InteriorDesignState();
}

class  InteriorDesignState extends State <InteriorDesign> {
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const MYCEBackButton(),
            const NavigationWidget(navigationItems: ['Architecture & Design', 'Interior Design']),
            Container(
              height: Responsive.height(80, context),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap:(){Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const InteriorVilla()),
                        );},
                      child: const ImageCard(
                        title: 'Villa',
                        description: 'Planning and creating the aesthetic and functional layout of the inside spaces of a luxury house.',
                        imagePath: 'assets/images/execution/villa.png',)
                        
                    ),
                    GestureDetector(
                      onTap:(){Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const InteriorBungalow()),
                        );},
                      child: const ImageCard(
                        title: 'Bungalow',
                        description: 'Planning and creating the interior layout, decor, and furnishings for a single-story house.',
                        imagePath: 'assets/images/execution/bungalow.png',)
                        
                    ),
                    GestureDetector(
                      onTap:(){Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const InteriorFarmhouse()),
                        );;},
                      child: const ImageCard(
                        title: 'Farmhouse',
                        description: 'Planning and creating the interior layout, decor, and furnishings of a rural residential building.',
                        imagePath: 'assets/images/execution/farmhouse.png',)
                        
                    ),
                    GestureDetector(
                      onTap:(){Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const InteriorResidential()),
                        );},
                      child: const ImageCard(
                        title: 'Residential Apartment',
                        description: 'Planning and creating the interior layout, decor, and functionality of a housing unit within a multi-story building.',
                        imagePath: 'assets/images/execution/apartment.png',)
                        
                    ),
                    GestureDetector(
                      onTap:(){Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const InteriorCommercial()),
                        );},
                      child: const ImageCard(
                        title: 'Commercial',
                        description: 'Retail spaces, Office Spaces',
                        imagePath: 'assets/images/execution/apartment.png',)
                        
                    ),
                    GestureDetector(
                      onTap:(){Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const InteriorIndustrial()),
                        );},
                      child: const ImageCard(
                        title: 'Industrial',
                        description: 'Warehouses, Factories, Modern Sheds.',
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