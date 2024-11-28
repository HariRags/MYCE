
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
import 'package:kriv/pages/project_management/contactus_pre.dart';
import 'package:kriv/utilities/architecture_design_bloc.dart';
import 'package:kriv/utilities/house_post.dart';
import 'package:kriv/utilities/responsive.dart';

import 'package:kriv/widgets/myce_backbutton.dart';
import 'package:kriv/widgets/navigation.dart';
import 'package:kriv/widgets/plaincard.dart';

import '../../widgets/imagecard.dart';

class PreConstruction extends StatefulWidget {
  final String? authToken;
  const PreConstruction({Key? key, required this.authToken}) : super(key: key);

  @override
  State <PreConstruction> createState() =>  PreConstructionState();
}

class  PreConstructionState extends State <PreConstruction> {
  @override
  Widget build(BuildContext context) {
    String? auth_token;
  String authToken = "";
  @override
  void initState(){
    super.initState();
    auth_token = widget.authToken;
    authToken = auth_token!;
    authToken =  authToken;
  }
  
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const MYCEBackButton(),
            const NavigationWidget(navigationItems: ['Project Management', 'Project Management Consultancy','Pre Construction Phase']),
            Container(
              height: Responsive.height(70, context),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    GestureDetector(
                      child: const PlainCard(
                        title: 'Follow up with architects for design',
                        description: 'Check on the progress or discuss any updates regarding the architectural plans for a project.',
                       
                      ),
                    ),
                    GestureDetector(
                      child: const PlainCard(
                        title: 'Follow up for sanction plan',
                        description: 'Inquiring about the approval status of a building plan from the relevant authorities.',
                     
                      ),
                    ),
                    GestureDetector(
                      child: const PlainCard(
                        title: 'Finalizing the contractors',
                        description: 'Selecting and confirming the construction company or individual who will undertake the building work.',
                      
                      ),
                    ),
                   SizedBox(
                      height: Responsive.height(2.2, context),
                    ),
                    
                    Container(
                      width: Responsive.width(95, context),
                      height: Responsive.height(6.5, context),
                      child: FilledButton(
                        // FIX ME : write submit form when backend is done
                        onPressed: (){
                          Navigator.push(
          context,
          MaterialPageRoute(
            // push to a contact us
            builder: (context) => PreContactUs(),
            settings: RouteSettings(arguments: auth_token) // Replace with your next page
          ));
                        },
                        child: Text(
                          'Contact Us',
                          style: TextStyle(fontSize: Responsive.height(2.3, context)),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            const Color.fromRGBO(107, 67, 151, 1),
                          ),
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13))),
                        ),
                      ),
                    )
                  ],
                ),
              ),
        )],
        ),
      ),
    );
  }
}