
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kriv/pages/architecture_and_design/interior_bungalow.dart';
import 'package:kriv/pages/architecture_and_design/interior_commercial.dart';
import 'package:kriv/pages/architecture_and_design/interior_farmhouse.dart';
import 'package:kriv/pages/architecture_and_design/interior_industrial.dart';
import 'package:kriv/pages/architecture_and_design/interior_residential.dart';
import 'package:kriv/pages/architecture_and_design/interior_villa.dart';
import 'package:kriv/pages/architecture_and_design/structure_bungalow.dart';
import 'package:kriv/pages/architecture_and_design/structure_commercial.dart';
import 'package:kriv/pages/architecture_and_design/structure_farmhouse.dart';
import 'package:kriv/pages/architecture_and_design/structure_industrial.dart';
import 'package:kriv/pages/architecture_and_design/structure_residential.dart';
import 'package:kriv/pages/architecture_and_design/structure_villa.dart';
import 'package:kriv/utilities/responsive.dart';

import 'package:kriv/widgets/myce_backbutton.dart';
import 'package:kriv/widgets/navigation.dart';

import '../../widgets/card.dart';

class StrcutureDesign extends StatefulWidget {
  const StrcutureDesign({Key? key}) : super(key: key);

  @override
  State <StrcutureDesign> createState() =>  StrcutureDesignState();
}

class  StrcutureDesignState extends State <StrcutureDesign> {
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const MYCEBackButton(),
            const NavigationWidget(navigationItems: ['Architecture & Design', 'Structure Design']),
            Container(
              height: Responsive.height(80, context),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap:(){const StructureVilla();},
                      child: const ImageCard(
                        title: 'Villa',
                        description: 'Planning and creating the architectural framework and support systems for a luxury house.',
                        imagePath: 'assets/images/execution/villa.png',)
                        
                    ),
                    GestureDetector(
                      onTap:(){const StructureBungalow();},
                      child: const ImageCard(
                        title: 'Bungalow',
                        description: 'Planning and creating the architectural framework and support systems for a single-story house.',
                        imagePath: 'assets/images/execution/bungalow.png',)
                        
                    ),
                    GestureDetector(
                      onTap:(){const StructureFarmhouse();},
                      child: const ImageCard(
                        title: 'Farmhouse',
                        description: 'Planning and creating the architectural framework and support systems for a rural residential building typically surrounded by agricultural land.',
                        imagePath: 'assets/images/execution/farmhouse.png',)
                        
                    ),
                    GestureDetector(
                      onTap:(){const StructureResidential();},
                      child: const ImageCard(
                        title: 'Residential Apartment',
                        description: 'Planning and creating the architectural framework and support systems for a multi-story housing unit.',
                        imagePath: 'assets/images/execution/apartment.png',)
                        
                    ),
                    GestureDetector(
                      onTap:(){const StructureCommercial();},
                      child: const ImageCard(
                        title: 'Commercial',
                        description: 'Planning and creating the architectural framework and support systems for areas used for business activities or providing services.',
                        imagePath: 'assets/images/execution/apartment.png',)
                        
                    ),
                    GestureDetector(
                      onTap:(){const StructureIndustrial();},
                      child: const ImageCard(
                        title: 'Industrial',
                        description: 'Planning and creating the architectural framework and support systems for areas used in manufacturing, production, or storage of goods.',
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