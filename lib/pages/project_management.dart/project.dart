
import 'package:flutter/material.dart';

import 'package:kriv/widgets/myce_backbutton.dart';
import 'package:kriv/widgets/navigation.dart';

import '../../widgets/card.dart';

class Project extends StatefulWidget {
  const Project({Key? key}) : super(key: key);

  @override
  State <Project> createState() =>  ProjectState();
}

class  ProjectState extends State <Project> {
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const MYCEBackButton(),
            const NavigationWidget(navigationItems: ['Project Management', 'Project management consultancy']),
            SingleChildScrollView(
              child: Column(
                children: [
                  InkWell(
                    onTap:(){},
                    child: const ImageCard(
                      title: 'Pre Construction phase',
                      description: 'Initial planning and preparation stage of a construction project before any physical work begins.',
                      imagePath: 'assets/images/execution/villa.png',)
                      
                  ),
                  InkWell(
                    onTap:(){},
                    child: const ImageCard(
                      title: 'Execution phase',
                      description: 'The stage of a project where the plans are put into action and the project is carried out.',
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