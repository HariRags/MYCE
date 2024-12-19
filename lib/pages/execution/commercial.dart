import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kriv/pages/execution/commercial_warehouse.dart';
import 'package:kriv/pages/execution/commerical_factory.dart';
import 'package:kriv/pages/login/login.dart';
import 'package:kriv/utilities/commercial_bloc.dart';
import 'package:kriv/utilities/global.dart';

import 'package:kriv/widgets/myce_backbutton.dart';
import 'package:kriv/widgets/navigation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/imagecard.dart';

class Commercial extends StatefulWidget {
  final String? authToken;
  const Commercial({Key? key,required this.authToken}) : super(key: key);

  @override
  State<Commercial> createState() => CommercialState();
}

class CommercialState extends State<Commercial> {
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
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const MYCEBackButton(),
            const NavigationWidget(
                navigationItems: ['Execution', 'Commercial']),
            SingleChildScrollView(
              child: Column(
                children: [
                  GestureDetector(
                      onTap: () {
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
                                create: (context) => CommercialBloc(authToken),
                                child: const CommercialFactory(),
                              ),
                            ),
                          );
                        }
                      },
                      child: const ImageCard(
                        title: 'Factory Structure',
                        description:
                            'The overall layout and organization of a manufacturing facility, including buildings, equipment, and workflow.',
                        imagePath: 'assets/images/execution/villa.png',
                      )),
                  GestureDetector(
                      onTap: () {
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
                                create: (context) => CommercialBloc(authToken),
                                child: const CommercialWarehouse(),
                              ),
                            ),
                          );
                        }
                      },
                      child: const ImageCard(
                        title: 'Warehouses',
                        description:
                            'Large buildings used for storing goods or merchandise, typically used in logistics and supply chain operations.',
                        imagePath: 'assets/images/execution/bungalow.png',
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
