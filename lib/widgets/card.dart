import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kriv/utilities/responsive.dart';


class ImageCard extends StatefulWidget {
  const ImageCard({Key? key, required this.title, required this.description, required this.imagePath}) : super(key: key);
  final String title;
  final String description;
  final String imagePath;
  @override
  State<ImageCard> createState() => _ImageCardState();
}

class _ImageCardState extends State<ImageCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
                        margin: EdgeInsets.only(left: Responsive.width(4, context), right: Responsive.width(4, context), bottom: Responsive.height(2, context)),
                        elevation: 6,
                        surfaceTintColor: Colors.white,
                        color: Colors.white,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              
                              margin: EdgeInsets.only(bottom:Responsive.height(1, context),),
                              width: Responsive.width(65, context),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                        padding: EdgeInsets.fromLTRB(
                                          Responsive.width(8, context),
                                          Responsive.height(2.5, context),
                                          Responsive.width(5, context),
                                          0,
                                        ),
                               child:  Text(widget.title, style: TextStyle(fontFamily:'Poppins', fontSize: Responsive.height(2.5, context), color: Colors.black, fontWeight: FontWeight.w600, letterSpacing: 0.5),),
                                  ),
                                Padding(
                                  padding:  EdgeInsets.fromLTRB(
                                          Responsive.width(8, context),
                                          0,
                                          Responsive.width(5, context),
                                          Responsive.height(0.6, context),
                                        ),
                                  child: Text(widget.description, style: TextStyle(fontFamily: 'Poppins', color: Color.fromRGBO(81, 81, 81, 1)),),
                                )
                              ],),
                            ),
                           Container(
                            height: Responsive.height(12.5, context),
                             child: Image.asset(
                               widget.imagePath,
                               fit: BoxFit.cover,
                             ),
                           ),
                          ],
                        ),
                      );
  }
}