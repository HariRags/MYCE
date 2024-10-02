import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kriv/utilities/responsive.dart';

import 'package:kriv/widgets/myce_backbutton.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => EditProfileState();
}

class EditProfileState extends State<EditProfile> {
  final TextEditingController _controllerMail = TextEditingController();
  final TextEditingController _controllerNumber = TextEditingController();
  final TextEditingController _controllerName = TextEditingController();

  final picker = ImagePicker();
  File? file;
  XFile? pickedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MYCEBackButton(),
            Container(
              margin: EdgeInsets.only(
                  left: Responsive.width(5, context),
                  top: Responsive.height(3, context)),
              child: const Text(
                'Edit Profile',
                style: TextStyle(
                  color: Color(0xFF303030),
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  height: 0.10,
                ),
              ),
            ),
            SizedBox(
              height: Responsive.height(4, context),
            ),
            Center(
              child: Stack(children: <Widget>[
                const CircleAvatar(
                  radius: 60.0,
                ),
                Positioned(
                  top: 0.0,
                  right: -13,
                  child: InkWell(
                    onTap: () async {
                      pickedImage =
                          await picker.pickImage(source: ImageSource.gallery);
                      setState(() {
                        file = File(pickedImage!.path);
                      });
                    },
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.mode_edit_outline_outlined,
                        size: 30,
                      ),
                      color: const Color(0xFF6B4397),
                    ),
                  ),
                ),
              ]),
            ),
            Container(
              height: Responsive.height(10.5, context),
              margin: EdgeInsets.only(
                  top: Responsive.height(3, context),
                  left: Responsive.width(5, context)),
              child: ListView(
                padding: EdgeInsets.only(right: Responsive.width(5, context)),
                children: [
                  const Text(
                    //label
                    'Name',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextField(
                    keyboardType: TextInputType.name,
                    controller: _controllerName,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 2, color: Color(0x33111112)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 2, color: Color(0x33111112)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    style: const TextStyle(
                      color: Color(0x99111112),
                      fontSize: 17,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: Responsive.height(10.5, context),
              margin: EdgeInsets.only(
                  top: Responsive.height(3, context),
                  left: Responsive.width(5, context)),
              child: ListView(
                padding: EdgeInsets.only(right: Responsive.width(5, context)),
                children: [
                  const Text(
                    //label
                    'Phone Number',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: _controllerNumber,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 2, color: Color(0x33111112)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 2, color: Color(0x33111112)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    style: const TextStyle(
                      color: Color(0x99111112),
                      fontSize: 17,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: Responsive.height(10.5, context),
              margin: EdgeInsets.only(
                  top: Responsive.height(3, context),
                  left: Responsive.width(5, context)),
              child: ListView(
                padding: EdgeInsets.only(right: Responsive.width(5, context)),
                children: [
                  const Text(
                    //label
                    'Email ID',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _controllerMail,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 2, color: Color(0x33111112)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 2, color: Color(0x33111112)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    style: const TextStyle(
                      color: Color(0x99111112),
                      fontSize: 17,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all<Color>(const Color(0xFF6B4397)),
                    shape: WidgetStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14))),
                    fixedSize: WidgetStateProperty.all<Size>(Size(
                        Responsive.width(90, context),
                        Responsive.height(7.2, context))),
                  ),
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      height: 0.07,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
