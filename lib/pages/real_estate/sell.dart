
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kriv/pages/real_estate/sell_commercial.dart';
import 'package:kriv/pages/real_estate/sell_land.dart';
import 'package:kriv/pages/real_estate/sell_residential.dart';
import 'package:kriv/utilities/responsive.dart';

import 'package:kriv/widgets/myce_backbutton.dart';
import 'package:kriv/widgets/navigation.dart';

import '../../widgets/card.dart';

class Sell extends StatefulWidget {
  const Sell({Key? key}) : super(key: key);

  @override
  State <Sell> createState() =>  SellState();
}

class  SellState extends State <Sell> {
  @override
  Widget build(BuildContext context) {
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
                      onTap:(){const SellLand();},
                      child: const ImageCard(
                        title: 'Land',
                        description: 'A person or entity purchases a piece of land, usually for development, investment, or personal use.',
                        imagePath: 'assets/images/execution/villa.png',)
                        
                    ),
                    GestureDetector(
                      onTap:(){const SellResidential();},
                      child: const ImageCard(
                        title: 'Residential',
                        description: 'A person or entity purchases a residential property for personal use or investment.',
                        imagePath: 'assets/images/execution/bungalow.png',)
                        
                    ),
                    GestureDetector(
                      onTap:(){const SellCommercial ();},
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