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
import 'package:kriv/utilities/architecture_design_bloc.dart';
import 'package:kriv/utilities/house_post.dart';
import 'package:kriv/utilities/responsive.dart';

import 'package:kriv/widgets/myce_backbutton.dart';
import 'package:kriv/widgets/navigation.dart';
import 'package:kriv/widgets/plaincard.dart';

import '../../widgets/imagecard.dart';

class PreContactUs extends StatefulWidget {
  const PreContactUs({Key? key}) : super(key: key);

  @override
  State<PreContactUs> createState() => PreContactUsState();
}

class PreContactUsState extends State<PreContactUs> {
  @override
  Widget build(BuildContext context) {
    @override
    void initState() {
      super.initState();
    }

    return Scaffold(
      body: SafeArea(
          child: Column(children: [
        const MYCEBackButton(),
        // const NavigationWidget(navigationItems: ['Project Management','Project Management Phase', 'Execution Phase']),
        Container(
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    left: Responsive.width(3.5, context),
                    right: Responsive.width(3.5, context),
                  ),
                  child: Text(
                    'Contact Us',
                    style: TextStyle(
                        fontFamily: 'Fraunces',
                        fontWeight: FontWeight.w600,
                        fontSize: Responsive.height(2.5, context)),
                  ),
                ),
                SizedBox(
                  height: Responsive.height(1, context),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: Responsive.width(3.5, context),
                    right: Responsive.width(3.5, context),
                  ),
                  child: Text(
                    'Please feel free to contact your civil engineer anytime. We will reach out to you as soon as possible.',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        fontSize: Responsive.height(1.5, context)),
                  ),
                ),
                SizedBox(
                  height: Responsive.height(1.5, context),
                ),
                Container(
                  height: Responsive.height(70, context),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        GestureDetector(
                          child: const PlainCard(
                            title: 'E-mail',
                            description: 'abc@gmail.com',
                          ),
                        ),
                        GestureDetector(
                          child: const PlainCard(
                            title: 'Phone',
                            description: '+91 9999999999',
                          ),
                        ),
                        GestureDetector(
                          child: const PlainCard(
                            title: 'Address',
                            description:
                                'Sanjay Nagar, Bengaluru, Karnataka-560054.',
                          ),
                        ),
                        GestureDetector(
                          child: const PlainCard(
                            title: 'Timing',
                            description: '9.00 am -5.00 pm',
                          ),
                        ),
                        SizedBox(
                          height: Responsive.height(2.2, context),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ))
      ])),
    );
  }
}
