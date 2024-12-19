
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kriv/pages/architecture_and_design/architecture_bungalow.dart';
import 'package:kriv/pages/architecture_and_design/architecture_commercial.dart';
import 'package:kriv/pages/architecture_and_design/architecture_farmhouse.dart';
import 'package:kriv/pages/architecture_and_design/architecture_industrial.dart';
import 'package:kriv/pages/architecture_and_design/architecture_residential.dart';
import 'package:kriv/pages/architecture_and_design/architecture_villa.dart';
import 'package:kriv/pages/login/login.dart';
import 'package:kriv/utilities/architecture_design_bloc.dart';
import 'package:kriv/utilities/house_post.dart';
import 'package:kriv/utilities/responsive.dart';

import 'package:kriv/widgets/myce_backbutton.dart';
import 'package:kriv/widgets/navigation.dart';

import '../../widgets/imagecard.dart';

class ArchitectureDesign extends StatefulWidget {
  final String? authToken;
  const ArchitectureDesign({Key? key, required this.authToken}) : super(key: key);

  @override
  State <ArchitectureDesign> createState() =>  ArchitectureDesignState();
}

class  ArchitectureDesignState extends State <ArchitectureDesign> {
  @override
  Widget build(BuildContext context) {
    String? auth_token;
  String authToken = widget.authToken!;
  @override
  void initState(){
    super.initState();
 
  }

    return Scaffold(
      
      body: SafeArea(
        child: Column(
          children: [
            const MYCEBackButton(),
            const NavigationWidget(navigationItems: ['Architecture & Design', 'Architecture Design']),
            Container(
              height: Responsive.height(76, context),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if(authToken==''){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()));
                          return;
                        }else{
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                  create: (context) =>
                                      ArchitectureBloc(authToken),
                                  child: const ArchitectureVilla()),
                            ),
                          );
                        }
                      },
                      child: const ImageCard(
                        title: 'Villa',
                        description: 'Planning and creating the layout, appearance, and functionality of a luxury house.',
                        imagePath: 'assets/images/execution/villa.png',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if(authToken==''){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()));
                          return;
                        }else{
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                  create: (context) =>
                                      ArchitectureBloc(authToken),
                                  child: const ArchitectureBungalow()),
                            ),
                          );
                        }
                      },
                      child: const ImageCard(
                        title: 'Bungalow',
                        description: 'Planning and creating the layout, appearance, and functionality of a single-story house.',
                        imagePath: 'assets/images/execution/bungalow.png',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if(authToken==''){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()));
                          return;
                        }else{
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                  create: (context) =>
                                      ArchitectureBloc(authToken),
                                  child: const ArchitectureFarmhouse()),
                            ),
                          );
                        }
                      },
                      child: const ImageCard(
                        title: 'Farmhouse',
                        description: 'Planning and creating the layout, appearance, and functionality of a rural residential building typically surrounded by agricultural land.',
                        imagePath: 'assets/images/execution/farmhouse.png',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if(authToken==''){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()));
                          return;
                        }else{
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                  create: (context) =>
                                      ArchitectureBloc(authToken),
                                  child: const ArchitectureResidential()),
                            ),
                          );
                        }
                      },
                      child: const ImageCard(
                        title: 'Residential Apartment',
                        description: 'Planning and creating the layout, appearance, and functionality of a housing unit within a multi-story building.',
                        imagePath: 'assets/images/execution/apartment.png',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if(authToken==''){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()));
                          return;
                        }else{
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                  create: (context) =>
                                      ArchitectureBloc(authToken),
                                  child: const ArchitectureCommercial()),
                            ),
                          );
                        }
                      },
                      child: const ImageCard(
                        title: 'Commercial',
                        description: 'Planning and creating the layout, appearance, and functionality of areas used for conducting business activities or providing services.',
                        imagePath: 'assets/images/execution/apartment.png',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                       if(authToken==''){
                        Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()));
                          return;
                        }else{
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                  create: (context) =>
                                      ArchitectureBloc(authToken),
                                  child: const ArchitectureIndustrial()),
                            ),
                          );
                        }
                      },
                      child: const ImageCard(
                        title: 'Industrial',
                        description: 'Planning and creating the layout, appearance, and functionality of areas used for manufacturing, production, or storage of goods.',
                        imagePath: 'assets/images/execution/apartment.png',
                      ),
                    ),
                  ],
                ),
              ),
        )],
        ),
      ),
    );
  }
}