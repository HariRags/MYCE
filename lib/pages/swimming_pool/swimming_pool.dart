
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kriv/pages/swimming_pool/pool_equipment.dart';
import 'package:kriv/pages/swimming_pool/pool_execution.dart';
import 'package:kriv/pages/swimming_pool/pool_maintenance.dart';
import 'package:kriv/utilities/global.dart';
import 'package:kriv/utilities/responsive.dart';
import 'package:kriv/utilities/swimming_bloc.dart';

import 'package:kriv/widgets/myce_backbutton.dart';
import 'package:kriv/widgets/navigation.dart';

import '../../widgets/imagecard.dart';

class SwimmingPool extends StatefulWidget {
  final String? authToken;
  const SwimmingPool({Key? key,required this.authToken}) : super(key: key);

  @override
  State <SwimmingPool> createState() =>  SwimmingPoolState();
}

class  SwimmingPoolState extends State <SwimmingPool> {
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
    print(authToken);
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
                      onTap:(){
                        if (globals.accessToken == '') {
                            return;
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                  create: (context) => SwimmingBloc(authToken),
                                  child: PoolExecution(authToken: authToken),
                                ),
                              ),
                            );
                          }
                        },
                      child: const ImageCard(
                        title: 'Execution ',
                        description: 'This involves the physical construction and installation of the pool based on the design plans.',
                        imagePath: 'assets/images/execution/villa.png',)
                        
                    ),
                    InkWell(
                      onTap:(){if (globals.accessToken == '') {
                            return;
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                  create: (context) => SwimmingBloc(authToken),
                                  child: PoolMaintanence(authToken: authToken),
                                ),
                              ),
                            );
                          }},
                      child: const ImageCard(
                        title: 'Maintenance',
                        description: 'This involves cleaning, repairing, and ensuring the proper functioning of the pool and its equipment.',
                        imagePath: 'assets/images/execution/bungalow.png',)
                        
                    ),
                    InkWell(
                      onTap:(){if (globals.accessToken == '') {
                            return;
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                  create: (context) => SwimmingBloc(authToken),
                                  child: PoolEquipment(authToken: authToken),
                                ),
                              ),
                            );
                          }},
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