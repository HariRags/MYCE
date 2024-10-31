import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kriv/pages/execution/house_apartment.dart';
import 'package:kriv/pages/execution/house_bungalow.dart';
import 'package:kriv/pages/execution/house_farmhouse.dart';
import 'package:kriv/pages/execution/house_villa.dart';
import 'package:kriv/utilities/responsive.dart';
import 'package:kriv/utilities/house_post.dart';
import 'package:kriv/widgets/myce_backbutton.dart';
import 'package:kriv/widgets/navigation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/card.dart';

class House extends StatefulWidget {
  const House({Key? key}) : super(key: key);

  @override
  State<House> createState() => HouseState();
}

class HouseState extends State<House> {
  String authToken = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzI4OTI4MjQyLCJpYXQiOjE3Mjg4NDE4NDIsImp0aSI6IjlkOThjYThkNWE1MzRiNjdhZTczYTRhNmJjOGQ1ZDJkIiwidXNlcl9pZCI6IjQyNjg5NzBiLWNkMjktNDkxYS1iMzVjLTBlMjdjMTNkNTE3NyJ9.8G74Swg1-Hsyvu4yKFbwSMfQauQpp3JkQEZJZBpQ3HY";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const MYCEBackButton(),
            const NavigationWidget(navigationItems: ['Execution', 'House']),
            Container(
              height: Responsive.height(80, context),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (context) =>
                                    HouseBloc(authToken),
                                child: const HouseVilla(),
                              ),
                            ),
                          );
                        },
                        child: const ImageCard(
                          title: 'Villa',
                          description:
                              'A large and luxurious house, often located in a scenic or desirable area.',
                          imagePath: 'assets/images/execution/villa.png',
                        )),
                    GestureDetector(
                      onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (context) =>
                                    HouseBloc(authToken),
                                child: const HouseBungalow(),
                              ),
                            ),
                          );
                        },
                      
                        child: const ImageCard(
                          title: 'Bungalow',
                          description:
                              'A small, single-story house, often with a veranda.',
                          imagePath: 'assets/images/execution/bungalow.png',
                        )),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (context) =>
                                    HouseBloc(authToken),
                                child: const HouseFarmhouse(),
                              ),
                            ),
                          );
                        },
                        child: const ImageCard(
                          title: 'Farmhouse',
                          description:
                              'A house typically located in a rural or agricultural area, used as a residence and often surrounded by farmland.',
                          imagePath: 'assets/images/execution/farmhouse.png',
                        )),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (context) =>
                                    HouseBloc(authToken),
                                child: const HouseApartment(),
                              ),
                            ),
                          );
                        },
                        child: const ImageCard(
                          title: 'Apartment',
                          description:
                              'A self-contained housing unit within a larger building, often part of a residential complex.',
                          imagePath: 'assets/images/execution/apartment.png',
                        )),
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
