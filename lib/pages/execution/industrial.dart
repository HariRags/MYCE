
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kriv/pages/execution/industrial_office_space.dart';
import 'package:kriv/pages/execution/industrial_retail.dart';
import 'package:kriv/utilities/industry_post.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kriv/widgets/myce_backbutton.dart';
import 'package:kriv/widgets/navigation.dart';

import '../../widgets/imagecard.dart';

class Industrial extends StatefulWidget {
  final String? authToken;
  const Industrial({Key? key, required this.authToken}) : super(key: key);

  @override
  State <Industrial> createState() =>  IndustrialState();
}

class  IndustrialState extends State <Industrial> {
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
            const NavigationWidget(navigationItems: ['Execution', 'Industrial']),
            SingleChildScrollView(
              child: Column(
                children: [
                  GestureDetector(
                    onTap:() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (context) =>
                                    IndustryBloc(authToken),
                                child: const IndustrialOfficeSpace(),
                              ),
                            ),
                          );
                        },
                    child: const ImageCard(
                      title: 'Office Space',
                      description: 'Areas within a building specifically designed for working, typically equipped with desks, computers, and other work-related amenities.',
                      imagePath: 'assets/images/execution/villa.png',)
                      
                  ),
                  GestureDetector(
                    onTap:() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (context) =>
                                    IndustryBloc(authToken),
                                child: const IndustrialRetail(),
                              ),
                            ),
                          );
                        },
                    child: const ImageCard(
                      title: 'Retail Space',
                      description: 'Commercial areas where goods or services are sold directly to consumers.',
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