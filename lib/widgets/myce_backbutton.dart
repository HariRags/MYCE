import 'package:flutter/material.dart';
import '../utilities/responsive.dart';


class MYCEBackButton extends StatefulWidget {
  const MYCEBackButton({Key? key}) : super(key: key);

  @override
  State<MYCEBackButton> createState() => _MYCEBackButtonState();
}

class _MYCEBackButtonState extends State<MYCEBackButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
              margin: EdgeInsets.only(left:Responsive.width(3.5, context), bottom: Responsive.height(1, context),),
              child: Row(
                children: [
                  IconButton(
                    icon:  Icon(Icons.arrow_back_ios, size: Responsive.height(2.4, context)),
                    color: Colors.black,
                    visualDensity: VisualDensity.compact,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  GestureDetector(
                                    child: Image.asset('assets/images/myce_back_icon.png'),
                                    onTap: () {
                      Navigator.pop(context);
                    },
                                  ),
                ],
              ),
            );
  }
}