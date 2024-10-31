import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:kriv/widgets/myce_backbutton.dart';
import 'package:kriv/widgets/navigation.dart';
import 'package:kriv/utilities/responsive.dart';

import '../../widgets/card.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({Key? key}) : super(key: key);

  @override
  State<ProfileSettings> createState() => ProfileSettingsState();
}

class ProfileSettingsState extends State<ProfileSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const MYCEBackButton(),
            GestureDetector(
                onTap: () {},
                child: Card(
                  margin: EdgeInsets.only(
                      left: Responsive.width(4, context),
                      right: Responsive.width(4, context),
                      bottom: Responsive.height(2, context)),
                  elevation: 6,
                  surfaceTintColor: Colors.white,
                  color: Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: Responsive.height(13, context),
                        width: Responsive.width(20, context),
                        // color: Colors.red,
                        // child: Image.asset(
                        //   widget.imagePath,
                        //   fit: BoxFit.cover,
                        // ),
                        padding:
                            EdgeInsets.only(left: Responsive.width(5, context)),
                        child: const CircleAvatar(
                          radius: 30.0,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          bottom: Responsive.height(1, context),
                        ),
                        width: Responsive.width(55, context),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                Responsive.width(4, context),
                                Responsive.height(2.5, context),
                                Responsive.width(5, context),
                                0,
                              ),
                              child: const Text(
                                "Rohit Bisht",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.fromLTRB(
                                  Responsive.width(4, context),
                                  0,
                                  0,
                                  Responsive.height(0.6, context),
                                ),
                                child: const Text(
                                  'rohitbisht@gmail.com',
                                  style: TextStyle(
                                    color: Color(0xFFB3B3B3),
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                    height: 0,
                                  ),
                                )),
                            Padding(
                                padding: EdgeInsets.fromLTRB(
                                  Responsive.width(4, context),
                                  0,
                                  0,
                                  Responsive.height(0.6, context),
                                ),
                                child: const Text(
                                  '9373092739',
                                  style: TextStyle(
                                    color: Color(0xFFB3B3B3),
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                    height: 0,
                                  ),
                                ))
                          ],
                        ),
                      ),
                      Container(
                        child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Edit',
                              style: TextStyle(
                                color: Color(0xFF6B4397),
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                height: 0.09,
                              ),
                            )),
                      ),
                    ],
                  ),
                )),
            Row(
              children: [
                SizedBox(
                  width: Responsive.width(50, context),
                  height: Responsive.height(20, context),
                  child: GestureDetector(
                    onTap: () {},
                    child: Card(
                      margin: EdgeInsets.only(
                          left: Responsive.width(4, context),
                          right: Responsive.width(4, context),
                          bottom: Responsive.height(2, context)),
                      elevation: 6,
                      surfaceTintColor: Colors.white,
                      color: Colors.white,
                      child: Column(
                        children: [
                          SizedBox(height: Responsive.height(3, context)),
                          Image(
                            image: AssetImage('assets/images/chat_bubble.png'),
                            height: Responsive.height(8, context),
                          ),
                          const Text(
                            'Past Enquiries',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: Responsive.width(50, context),
                  height: Responsive.height(20, context),
                  child: GestureDetector(
                    onTap: () {},
                    child: Card(
                      margin: EdgeInsets.only(
                          left: Responsive.width(4, context),
                          right: Responsive.width(4, context),
                          bottom: Responsive.height(2, context)),
                      elevation: 6,
                      surfaceTintColor: Colors.white,
                      color: Colors.white,
                      child: Column(
                        children: [
                          SizedBox(height: Responsive.height(5, context)),
                          Icon(Icons.location_on_outlined,
                              size: Responsive.height(5, context),
                              color: Color.fromARGB(255, 133, 90, 180)),
                          SizedBox(height: Responsive.height(1, context)),
                          const Text(
                            'Address',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              width: Responsive.width(100, context),
              height: Responsive.height(30, context),
              child: GestureDetector(
                onTap: () {},
                child: Card(
                  margin: EdgeInsets.only(
                      left: Responsive.width(4, context),
                      right: Responsive.width(4, context),
                      bottom: Responsive.height(2, context)),
                  elevation: 6,
                  surfaceTintColor: Colors.white,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: Responsive.height(4, context)),
                      Row(
                        children: [
                          SizedBox(width: Responsive.width(8, context),),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Privacy Policy',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                'Important for both of us',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ],
                          ),
                          SizedBox(width: Responsive.width(35, context),),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black,
                          )
                        ],
                      ),
                      Divider(
                        indent: Responsive.width(8, context),
                        endIndent: Responsive.width(8, context),
                        height: Responsive.height(4, context),
                      ),
                      Row(
                        children: [
                          SizedBox(width: Responsive.width(8, context),),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Privacy Policy',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                'Important for both of us',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ],
                          ),
                          SizedBox(width: Responsive.width(35, context),),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black,
                          )
                        ],
                      ),
                      Divider(
                        indent: Responsive.width(8, context),
                        endIndent: Responsive.width(8, context),
                        height: Responsive.height(4, context),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: Responsive.height(4, context),
            ),
            TextButton(
              onPressed: () {},
              style: ButtonStyle(
                shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(color: Color(0xFFE30000), width: 2),
                )),
                fixedSize: MaterialStateProperty.all<Size>(Size(
                    Responsive.width(93, context),
                    Responsive.height(7.2, context))),
              ),
              child: const Text(
                "Delete Account",
                style: TextStyle(
                  color: Color(0xFFE30000),
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
