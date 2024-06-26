
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kriv/pages/real_estate/buy_commercial.dart';
import 'package:kriv/pages/real_estate/buy_land.dart';
import 'package:kriv/pages/real_estate/buy_residential.dart';
import 'package:kriv/utilities/responsive.dart';

import 'package:kriv/widgets/myce_backbutton.dart';
import 'package:kriv/widgets/navigation.dart';

import '../../widgets/card.dart';

class Buy extends StatefulWidget {
  const Buy({Key? key}) : super(key: key);

  @override
  State <Buy> createState() =>  BuyState();
}

class  BuyState extends State <Buy> {
  @override
  Widget build(BuildContext context) {
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
                      onTap:(){Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BuyLand()),
                        );},
                      child: const ImageCard(
                        title: 'Land',
                        description: 'Ownership of land is transferred from the seller to the buyer in exchange for an agreed-upon price.',
                        imagePath: 'assets/images/execution/villa.png',)
                        
                    ),
                    GestureDetector(
                      onTap:(){Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BuyResidential()),
                        );},
                      child: const ImageCard(
                        title: 'Residential',
                        description: 'Selling of a residential property by property owner to a buyer, typically facilitated by a real estate agent or broker.',
                        imagePath: 'assets/images/execution/bungalow.png',)
                        
                    ),
                    InkWell(
                      onTap:(){Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BuyCommercial()),
                        );},
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