// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:kriv/pages/homepage.dart';
import 'package:kriv/utilities/responsive.dart';
import 'package:kriv/widgets/myce_backbutton.dart';
import 'package:kriv/widgets/navigation.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(children: [
      const MYCEBackButton(),
      Container(
          margin: EdgeInsets.only(
            left: Responsive.width(3.5, context),
            right: Responsive.width(3.5, context),
          ),
          alignment: Alignment.topLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add your info',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: Responsive.height(2.5, context)),
              ),
              SizedBox(
                height: Responsive.height(2, context),
              ),
              Container(
                  padding: EdgeInsets.only(left: Responsive.width(2, context)),
                  height: Responsive.height(5, context),
                  alignment: Alignment.topLeft,
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: const Color.fromRGBO(149, 149, 149, 1)),
                      borderRadius: BorderRadius.circular(6)),
                  child: Form(
                    child: TextFormField(
                      
                      decoration: InputDecoration(
                          hintText: 'Name',
                          hintStyle: const TextStyle(
                              color: Color.fromRGBO(149, 149, 149, 1),),
                          contentPadding: EdgeInsets.only(
                              left: Responsive.width(1, context),
                              bottom: Responsive.height(1.2, context)),
                          border: InputBorder.none),
                    ),
                  )),
              SizedBox(
                height: Responsive.height(3, context),
              ),
              Container(
                  padding: EdgeInsets.only(left: Responsive.width(2, context)),
                  height: Responsive.height(5, context),
                  alignment: Alignment.topLeft,
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: const Color.fromRGBO(149, 149, 149, 1)),
                      borderRadius: BorderRadius.circular(6)),
                  child: Form(
                    child: TextFormField(
                      
                      decoration: InputDecoration(
                          hintText: 'Phone number',
                          hintStyle: const TextStyle(
                              color: Color.fromRGBO(149, 149, 149, 1),),
                          contentPadding: EdgeInsets.only(
                              left: Responsive.width(1, context),
                              bottom: Responsive.height(1.2, context)),
                          border: InputBorder.none),
                    ),
                  )),
                                SizedBox(
                height: Responsive.height(3, context),
              ),
                  Container(
                  padding: EdgeInsets.only(left: Responsive.width(2, context)),
                  height: Responsive.height(5, context),
                  alignment: Alignment.topLeft,
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: const Color.fromRGBO(149, 149, 149, 1)),
                      borderRadius: BorderRadius.circular(6)),
                  child: Form(
                    child: TextFormField(
                      
                      decoration: InputDecoration(
                          hintText: 'Email id',
                          hintStyle: const TextStyle(
                              color: Color.fromRGBO(149, 149, 149, 1),),
                          contentPadding: EdgeInsets.only(
                              left: Responsive.width(1, context),
                              bottom: Responsive.height(1.2, context)),
                          border: InputBorder.none),
                    ),
                  )),
                                  SizedBox(
                height: Responsive.height(3, context),
              ),
                  Container(
                  padding: EdgeInsets.only(left: Responsive.width(2, context)),
                  height: Responsive.height(5, context),
                  alignment: Alignment.topLeft,
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: const Color.fromRGBO(149, 149, 149, 1)),
                      borderRadius: BorderRadius.circular(6)),
                  child: Form(
                    child: TextFormField(
                      
                      decoration: InputDecoration(
                          hintText: 'Address',
                          hintStyle: const TextStyle(
                              color: Color.fromRGBO(149, 149, 149, 1),),
                          contentPadding: EdgeInsets.only(
                              left: Responsive.width(1, context),
                              bottom: Responsive.height(1.2, context)),
                          border: InputBorder.none),
                    ),
                  )),
                                  SizedBox(
                height: Responsive.height(3, context),
              ),
              
              
              Container(
                width: Responsive.width(95, context),
                height: Responsive.height(6.5, context),
                child: FilledButton(
                  onPressed: () {
                    // handle api call for signup
                    Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
                  },
                  child: Text(
                    'Done',
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
          ))
    ])));
  }
}
