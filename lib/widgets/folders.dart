
import 'package:flutter/material.dart';
import '../utilities/responsive.dart';

class Folders extends StatefulWidget {
  const Folders({Key? key, required this.title,required this.titleColor, this.description= '',required this.color,required this.numberOfButtons,required this.buttonColor,required this.buttonTextColor,required this.buttonText}) : super(key: key) ;
  final String title;
  final Color? titleColor;
  final String description;
  final Color? color;
  final int? numberOfButtons;
  final Color? buttonColor;
  final Color? buttonTextColor;
  final List<String> buttonText;


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
            color: widget.color,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: Responsive.height(2, context),
            ),
            Container(
              padding: EdgeInsets.only(left: Responsive.width(8, context)),
              child: Text(
                widget.title,
                style: TextStyle(
                    color: widget.titleColor, 
                    fontSize: Responsive.height(2.7, context),
                    fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: Responsive.height(4.1, context),
            ),
            widget.description.isNotEmpty
            ? _Description(description: widget.description, titleColor: widget.titleColor!, context: context)
            :Container(),

            widget.description.isNotEmpty
            ?SizedBox(
              height: Responsive.height(2, context),
            )
            :Container(),

            _FolderButtons(numberOfButtons: widget.numberOfButtons!, buttonText: widget.buttonText, buttonColor:widget.buttonColor!, buttonTextColor: widget.buttonTextColor!, context: context)
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
    path.lineTo(size.width * 0.58, 0.0);
    path.cubicTo(size.width * 0.69, size.height * 0, size.width * 0.70,
        size.height * 0.08, size.width * 0.81, size.height * 0.08);
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
class _Description extends StatelessWidget {
  final String description;
  final Color titleColor;
  final BuildContext context;

  const _Description({Key? key, required this.description,required this.titleColor,required this.context}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: Responsive.width(8, context),
          right: Responsive.width(4, context)),
      child: Text(
        description,
        softWrap: true,
        style: TextStyle(
          color: Color(0xFFE5E5E5),
          fontSize: Responsive.height(1.7, context),
          
        ),
      ),
    );
  }
}
class _FolderButtons extends StatelessWidget {
  final int numberOfButtons;
  final List<String> buttonText;
  final Color buttonColor;
  final Color buttonTextColor;
  final BuildContext context;

  const _FolderButtons({Key? key, 
    required this.numberOfButtons,
    required this.buttonText,
    required this.buttonColor,
    required this.buttonTextColor,
    required this.context,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: Responsive.width(8, context),
        right: Responsive.width(4, context),
      ),
      child: Wrap(
        spacing: Responsive.width(3, context),
        runSpacing: Responsive.height(2, context),
        children: List<Widget>.generate(numberOfButtons, (index) {
          return Container(
            width: Responsive.width(35, context),
            height: Responsive.height(7, context),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: buttonColor,
            ),
            child: Center(
              child: TextButton(
                child: Text(
                  buttonText[index],
                  style: TextStyle(
                    color: buttonTextColor,
                    fontSize: Responsive.height(2.0, context),
                  ),
                ),
                onPressed: () {},
              ),
            ),
          );
        }),
      ),
    );
  }
}
