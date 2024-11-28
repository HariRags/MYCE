
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kriv/pages/project_management/executionphase.dart';
import 'package:kriv/pages/project_management/preconstruction.dart';
import 'package:kriv/utilities/execution_bloc.dart';
import 'package:kriv/utilities/house_post.dart';

import 'package:kriv/widgets/myce_backbutton.dart';
import 'package:kriv/widgets/navigation.dart';

import '../../widgets/imagecard.dart';

class Project extends StatefulWidget {
  final String? authToken;
  const Project({Key? key,required this.authToken}) : super(key: key);

  @override
  State <Project> createState() =>  ProjectState();
}

class  ProjectState extends State <Project> {
  String? auth_token;
  String authToken = "";
  @override
  void initState(){
    super.initState();
    auth_token = widget.authToken;
    authToken = auth_token!;
    authToken =  authToken;
  }
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
                    onTap:(){
                      
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (context) =>
                                    ExecutionBloc(authToken),
                                child:  PreConstruction(authToken: authToken,),
                              ),
                            ),
                          );
                    },
                    child: const ImageCard(
                      title: 'Pre Construction phase',
                      description: 'Initial planning and preparation stage of a construction project before any physical work begins.',
                      imagePath: 'assets/images/execution/villa.png',)
                      
                  ),
                  InkWell(
                    onTap:(){
                      Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (context) =>
                                    ExecutionBloc(authToken),
                                child:  ExecutionPhase(authToken: authToken,),
                              ),
                            ),
                          );
                    },
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