
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kriv/pages/architecture_and_design/structure_bungalow.dart';
import 'package:kriv/pages/architecture_and_design/structure_commercial.dart';
import 'package:kriv/pages/architecture_and_design/structure_farmhouse.dart';
import 'package:kriv/pages/architecture_and_design/structure_industrial.dart';
import 'package:kriv/pages/architecture_and_design/structure_residential.dart';
import 'package:kriv/pages/architecture_and_design/structure_villa.dart';
import 'package:kriv/utilities/interior_bloc.dart';
import 'package:kriv/utilities/responsive.dart';
import 'package:kriv/utilities/structure_design_bloc.dart';

import 'package:kriv/widgets/myce_backbutton.dart';
import 'package:kriv/widgets/navigation.dart';

import '../../widgets/card.dart';

class StructureDesign extends StatefulWidget {
  final String? authToken;
  const StructureDesign({Key? key,required this.authToken}) : super(key: key);

  @override
  State <StructureDesign> createState() =>  StructureDesignState();
}

class  StructureDesignState extends State <StructureDesign> {
  @override
  Widget build(BuildContext context) {
    String? auth_token;
  String authToken = "";
  @override
  void initState(){
    super.initState();
    auth_token = widget.authToken;
    authToken = auth_token!;
    authToken =  authToken;
  }
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
                      onTap:(){Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) => StructureBloc(authToken),
                              child: const StructureVilla()
                              ),
                          ),
                        );},
                      child: const ImageCard(
                        title: 'Villa',
                        description: 'Planning and creating the architectural framework and support systems for a luxury house.',
                        imagePath: 'assets/images/execution/villa.png',)
                        
                    ),
                    GestureDetector(
                      onTap:(){Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) => StructureBloc(authToken),
                              child: const StructureBungalow()
                              ),
                          ),
                        );},
                      child: const ImageCard(
                        title: 'Bungalow',
                        description: 'Planning and creating the architectural framework and support systems for a single-story house.',
                        imagePath: 'assets/images/execution/bungalow.png',)
                        
                    ),
                    GestureDetector(
                      onTap:(){Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) => StructureBloc(authToken),
                              child: const StructureFarmhouse()
                              ),
                          ),
                        );},
                      child: const ImageCard(
                        title: 'Farmhouse',
                        description: 'Planning and creating the architectural framework and support systems for a rural residential building typically surrounded by agricultural land.',
                        imagePath: 'assets/images/execution/farmhouse.png',)
                        
                    ),
                    GestureDetector(
                      onTap:(){Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) => StructureBloc(authToken),
                              child: const StructureResidential()
                              ),
                          ),
                        );},
                      child: const ImageCard(
                        title: 'Residential Apartment',
                        description: 'Planning and creating the architectural framework and support systems for a multi-story housing unit.',
                        imagePath: 'assets/images/execution/apartment.png',)
                        
                    ),
                    GestureDetector(
                      onTap:(){Navigator.push(
                          context,
                         MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) => StructureBloc(authToken),
                              child: const StructureCommercial()
                              ),
                          ),
                        );},
                      child: const ImageCard(
                        title: 'Commercial',
                        description: 'Planning and creating the architectural framework and support systems for areas used for business activities or providing services.',
                        imagePath: 'assets/images/execution/apartment.png',)
                        
                    ),
                    GestureDetector(
                      onTap:(){Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) => StructureBloc(authToken),
                              child: const StructureIndustrial()
                              ),
                          ),
                        );},
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