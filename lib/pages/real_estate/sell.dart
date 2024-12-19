
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kriv/pages/login/login.dart';
import 'package:kriv/pages/real_estate/sell_commercial.dart';
import 'package:kriv/pages/real_estate/sell_land.dart';
import 'package:kriv/pages/real_estate/sell_residential.dart';
import 'package:kriv/utilities/global.dart';
import 'package:kriv/utilities/responsive.dart';
import 'package:kriv/utilities/sell_bloc.dart';

import 'package:kriv/widgets/myce_backbutton.dart';
import 'package:kriv/widgets/navigation.dart';

import '../../widgets/imagecard.dart';

class Sell extends StatefulWidget {
  final String? authToken;
  const Sell({Key? key,required this.authToken}) : super(key: key);

  @override
  State <Sell> createState() =>  SellState();
}

class  SellState extends State <Sell> {
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
    print('this $authToken');
    return   Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const MYCEBackButton(),
            const NavigationWidget(navigationItems: ['Real Estate', 'Sell']),
            Container(
              height: Responsive.height(80, context),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (globals.accessToken=='') {
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
                                    SellBloc(authToken),
                                child: const SellLand(),
                              ),
                            ),
                          );
                        }
                        },
                      child: const ImageCard(
                        title: 'Land',
                        description: 'A person or entity purchases a piece of land, usually for development, investment, or personal use.',
                        imagePath: 'assets/images/execution/villa.png',)
                        
                    ),
                    GestureDetector(
                      onTap:(){if (globals.accessToken=='') {
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
                                    SellBloc(authToken),
                                child: const SellResidential(),
                              ),
                            ),
                          );
                        }},
                      child: const ImageCard(
                        title: 'Residential',
                        description: 'A person or entity purchases a residential property for personal use or investment.',
                        imagePath: 'assets/images/execution/bungalow.png',)
                        
                    ),
                    GestureDetector(
                      onTap:(){if (globals.accessToken=='') {
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
                                    SellBloc(authToken),
                                child: const SellCommercial(),
                              ),
                            ),
                          );
                        }},
                      child: const ImageCard(
                        title: 'Commercial',
                        description: 'A business or investor purchases property for the purpose of generating income or conducting business activities.',
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