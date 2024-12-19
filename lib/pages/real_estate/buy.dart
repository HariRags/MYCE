
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kriv/pages/login/login.dart';
import 'package:kriv/pages/real_estate/buy_commercial.dart';
import 'package:kriv/pages/real_estate/buy_land.dart';
import 'package:kriv/pages/real_estate/buy_residential.dart';
import 'package:kriv/utilities/buy_bloc.dart';
import 'package:kriv/utilities/global.dart';
import 'package:kriv/utilities/responsive.dart';

import 'package:kriv/widgets/myce_backbutton.dart';
import 'package:kriv/widgets/navigation.dart';

import '../../widgets/imagecard.dart';

class Buy extends StatefulWidget {
  final String? authToken;
  const Buy({Key? key, required this.authToken}) : super(key: key);

  @override
  State <Buy> createState() =>  BuyState();
}

class  BuyState extends State <Buy> {
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
    print("this $authToken");
    return   Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const MYCEBackButton(),
            const NavigationWidget(navigationItems: ['Real Estate', 'Buy']),
            Container(
              height: Responsive.height(80, context),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap:(){
                        if (globals.accessToken == '') {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()));
                            return;
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                  create: (context) => BuyBloc(authToken),
                                  child: BuyLand(
                                    authToken: authToken,
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                      child: const ImageCard(
                        title: 'Land',
                        description: 'Ownership of land is transferred from the seller to the buyer in exchange for an agreed-upon price.',
                        imagePath: 'assets/images/execution/villa.png',)
                        
                    ),
                    GestureDetector(
                      onTap:(){
                        if (globals.accessToken == '') {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()));
                            return;
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                  create: (context) => BuyBloc(authToken),
                                  child: BuyResidential(
                                    authToken: authToken,
                                  ),
                                ),
                              ),
                            );
                          }},
                      child: const ImageCard(
                        title: 'Residential',
                        description: 'Selling of a residential property by property owner to a buyer, typically facilitated by a real estate agent or broker.',
                        imagePath: 'assets/images/execution/bungalow.png',)
                        
                    ),
                    InkWell(
                      onTap:(){if (globals.accessToken == '') {
                        Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()));
                            return;
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                  create: (context) => BuyBloc(authToken),
                                  child: BuyCommercial(
                                    authToken: authToken,
                                  ),
                                ),
                              ),
                            );
                          }},
                      child: const ImageCard(
                        title: 'Commercial',
                        description: 'A property intended for business use is marketed and sold to a buyer for commercial purposes.',
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