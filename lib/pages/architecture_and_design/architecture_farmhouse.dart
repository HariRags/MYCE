import 'package:flutter/material.dart';
import 'package:kriv/utilities/responsive.dart';
import 'package:kriv/widgets/myce_backbutton.dart';
import 'package:kriv/widgets/navigation.dart';

class ArchitectureFarmhouse extends StatefulWidget {
  const ArchitectureFarmhouse({Key? key}) : super(key: key);

  @override
  State<ArchitectureFarmhouse> createState() => _ArchitectureFarmhouseState();
}

class _ArchitectureFarmhouseState extends State<ArchitectureFarmhouse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(children: [
      const MYCEBackButton(),
      const NavigationWidget(navigationItems: ['Architecture & Design', 'Architecture Design', 'Farmhouse']),
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
                'Location',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: Responsive.height(2.5, context)),
              ),
              Text('MSR Nagar, Bengaluru, Karnataka- 560054, India.',
                  style: TextStyle(
                      fontSize: Responsive.height(1.5, context),
                      color: Colors.black)),
              SizedBox(
                height: Responsive.height(1, context),
              ),
              Container(
                  padding: EdgeInsets.only(left: Responsive.width(2, context)),
                  height: Responsive.height(4.5, context),
                  alignment: Alignment.topLeft,
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: const Color.fromRGBO(149, 149, 149, 1)),
                      borderRadius: BorderRadius.circular(6)),
                  child: Form(
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: 'House/ Flat/ Block Number',
                          hintStyle: TextStyle(
                            color: const Color.fromRGBO(132, 132, 132, 1),
                            fontSize: Responsive.height(1.6, context),
                            fontWeight: FontWeight.w400,
                          ),
                          contentPadding: EdgeInsets.only(
                              left: Responsive.width(1, context),
                              bottom: Responsive.height(1.2, context)),
                          border: InputBorder.none),
                    ),
                  )),
              SizedBox(
                height: Responsive.height(0.5, context),
              ),
              Container(
                  padding: EdgeInsets.only(left: Responsive.width(2, context)),
                  height: Responsive.height(4.5, context),
                  alignment: Alignment.topLeft,
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: const Color.fromRGBO(149, 149, 149, 1)),
                      borderRadius: BorderRadius.circular(6)),
                  child: Form(
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: 'Area/ Landmark/ Road',
                          hintStyle: TextStyle(
                            color: const Color.fromRGBO(132, 132, 132, 1),
                            fontSize: Responsive.height(1.6, context),
                            fontWeight: FontWeight.w400,
                          ),
                          contentPadding: EdgeInsets.only(
                              left: Responsive.width(1, context),
                              bottom: Responsive.height(1.2, context)),
                          border: InputBorder.none),
                    ),
                  )),
              SizedBox(
                height: Responsive.height(2.2, context),
              ),
              Text(
                'Land Size',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: Responsive.height(2.5, context)),
              ),
              SizedBox(
                height: Responsive.height(1, context),
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
                          contentPadding: EdgeInsets.only(
                              left: Responsive.width(1, context),
                              bottom: Responsive.height(1.2, context)),
                          border: InputBorder.none),
                    ),
                  )),
              SizedBox(
                height: Responsive.height(2.2, context),
              ),
              Text(
                'Digital Survey',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: Responsive.height(2.5, context)),
              ),
              SizedBox(
                height: Responsive.height(1, context),
              ),
              Row(
                children: [
                  Container(
                    height: Responsive.height(5.5, context),
                    width: Responsive.width(45, context),
                    child: OutlinedButton(
                      onPressed: () {},
                      child: Center(
                        child: Text('Yes',
                            style: TextStyle(
                                fontSize: Responsive.height(2.5, context))),
                      ),
                      style: ButtonStyle(
                        side: MaterialStateProperty.resolveWith<BorderSide>(
                            (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            return const BorderSide(
                                color: Colors
                                    .purple); // Border color when button is pressed
                          }
                          return const BorderSide(
                              color: Color.fromRGBO(105, 105, 105,
                                  1)); // Transparent border when button is not pressed
                        }),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Responsive.width(2, context),
                  ),
                  Container(
                    height: Responsive.height(5.5, context),
                    width: Responsive.width(45, context),
                    child: OutlinedButton(
                      onPressed: () {},
                      child: Center(
                        child: Text('No',
                            style: TextStyle(
                                fontSize: Responsive.height(2.5, context))),
                      ),
                      style: ButtonStyle(
                        side: MaterialStateProperty.resolveWith<BorderSide>(
                            (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            return const BorderSide(
                                color: Colors
                                    .purple); // Border color when button is pressed
                          }
                          return const BorderSide(
                              color: Color.fromRGBO(105, 105, 105,
                                  1)); // Transparent border when button is not pressed
                        }),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Responsive.height(2.5, context),
              ),
              Text(
                'Upload Floor Plan',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: Responsive.height(2.5, context)),
              ),
              SizedBox(
                height: Responsive.height(1, context),
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
                          hintText: '.pdf/.jpg/.png',
                          hintStyle: TextStyle(
                              color: const Color.fromRGBO(0, 0, 0, 1),
                              fontSize: Responsive.height(1.6, context),
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic),
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
                  onPressed: () {},
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
