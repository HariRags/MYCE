
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kriv/pages/execution/commercial_warehouse.dart';
import 'package:kriv/pages/execution/commerical_factory.dart';

import 'package:kriv/widgets/myce_backbutton.dart';
import 'package:kriv/widgets/navigation.dart';

import '../../widgets/card.dart';

class Commercial extends StatefulWidget {
  const Commercial({Key? key}) : super(key: key);

  @override
  State <Commercial> createState() =>  CommercialState();
}

class  CommercialState extends State <Commercial> {
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const MYCEBackButton(),
            const NavigationWidget(navigationItems: ['Execution', 'Commercial']),
            SingleChildScrollView(
              child: Column(
                children: [
                  GestureDetector(
                    onTap:(){const CommercialFactory();},
                    child: const ImageCard(
                      title: 'Factory Structure',
                      description: 'The overall layout and organization of a manufacturing facility, including buildings, equipment, and workflow.',
                      imagePath: 'assets/images/execution/villa.png',)
                      
                  ),
                  GestureDetector(  
                    onTap:(){const CommercialWarehouse();},
                    child: const ImageCard(
                      title: 'Warehouses',
                      description: 'Large buildings used for storing goods or merchandise, typically used in logistics and supply chain operations.',
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