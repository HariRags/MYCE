import 'dart:ffi' as ffi;

import 'package:flutter/material.dart';
import '../utilities/responsive.dart';

class Folders extends StatefulWidget {
  const Folders({Key? key, required this.title,required this.titleColor,required this.description,required this.color,required this.numberOfButtons,required this.buttonColor,required this.buttonTextColor,required this.buttonText}) : super(key: key) ;
  final String title;
  final Color? titleColor;
  final String description;
  final Color? color;
  final int? numberOfButtons;
  final Color? buttonColor;
  final Color? buttonTextColor;
  final ffi.Array? buttonText;


  @override
  State<Folders> createState() => _FoldersState();
}

class _FoldersState extends State<Folders> {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: FolderClipper(),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.purple.shade50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: Responsive.height(4.3, context),
            ),
            Container(
              padding: EdgeInsets.only(left: Responsive.width(8, context)),
              child: Text(
                'sd',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: Responsive.height(2.7, context),
                    fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: Responsive.height(4.1, context),
            ),
            Container(
                padding: EdgeInsets.only(
                    left: Responsive.width(8, context),
                    right: Responsive.width(4, context)),
                child: Text(
                  'the quick brown fox jumps over the diry dog and the dirty dog chases the quick brown fox',
                  softWrap: true,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: Responsive.height(1.7, context),
                  ),
                )),
            SizedBox(
              height: Responsive.height(2, context),
            ),
            Container(
              padding: EdgeInsets.only(
                  left: Responsive.width(8, context),
                  right: Responsive.width(4, context)),
              child: Wrap(
                spacing: Responsive.width(3, context),
                runSpacing: Responsive.height(2, context),
                children: List<Widget>.generate(4, (index) {
                  return Container(
                    width: Responsive.width(30, context),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.purple.shade300),
                    child: Center(
                        child: TextButton(
                      child:
                          Text('Button', style: TextStyle(color: Colors.white)),
                      onPressed: () {},
                    )),
                  );
                }),
              ),
            )
            
          ],
        ),
      ),
    );
  }
}

class FolderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0.0, 0.0);
    path.lineTo(size.width * 0.50, 0.0);
    path.cubicTo(size.width * 0.61, size.height * 0, size.width * 0.62,
        size.height * 0.08, size.width * 0.73, size.height * 0.08);
    path.lineTo(size.width * 0.93, size.height * 0.08);
    path.quadraticBezierTo(
        size.width, size.height * 0.081, size.width, size.height * 0.13);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.lineTo(0.0, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
