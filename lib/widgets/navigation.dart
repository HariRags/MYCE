import 'package:flutter/material.dart';
import 'package:kriv/utilities/responsive.dart';

class NavigationWidget extends StatefulWidget {
  const NavigationWidget({Key? key , required this.navigationItems}) : super(key: key);
  final List<String> navigationItems;
  @override
  State<NavigationWidget> createState() => _NavigationWidgetState();
}

class _NavigationWidgetState extends State<NavigationWidget> {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: Responsive.width(3.5, context),
        bottom: Responsive.height(3.2, context),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Wrap(
          alignment: WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.start,
          direction: Axis.horizontal,
          runSpacing: Responsive.height(0.5, context), // space between lines
          // spacing: Responsive.width(4, context), // space between items in the same line
          children: widget.navigationItems.asMap().entries.map((entry) {
            int index = entry.key;
            String item = entry.value;
            return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            item,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: Responsive.height(2.5, context),
              color: index == widget.navigationItems.length - 1 ? const Color.fromRGBO(70, 70, 70, 1) : const Color.fromRGBO(132, 132, 132, 1),
              fontWeight: index == widget.navigationItems.length - 1 ? FontWeight.w600 : null,
              letterSpacing: -0.2,
            ),
          ),
          if (index != widget.navigationItems.length - 1)
          SizedBox(
            width: Responsive.width(4, context),
          ),
          if (index != widget.navigationItems.length - 1)
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: const Color.fromRGBO(132, 132, 132, 1),
              size: Responsive.height(1.7, context),
            ),
            if (index != widget.navigationItems.length - 1)
          SizedBox(
            width: Responsive.width(4, context),
          ),
        ],
            );
          }).toList(),
        ),
      ),
      // child: Row(
      //   children: widget.navigationItems.asMap().entries.map((entry) {
      //     int index = entry.key;
      //     String item = entry.value;
      //     return Row(
      //       children: [
      //         Text(
      //           item,
      //           style: TextStyle(
      //             fontFamily: 'Poppins',
      //             fontSize: Responsive.height(2.5, context),
      //             color: index == widget.navigationItems.length - 1 ? const Color.fromRGBO(70, 70, 70, 1) : const Color.fromRGBO(132, 132, 132, 1),
      //             fontWeight: index == widget.navigationItems.length - 1 ? FontWeight.w600 : null,
      //             letterSpacing: -0.2,
      //           ),
      //         ),
      //         SizedBox(
      //           width: Responsive.width(4, context),
      //         ),
      //         if (index != widget.navigationItems.length - 1)
      //           Icon(
      //             Icons.arrow_forward_ios_rounded,
      //             color: const Color.fromRGBO(132, 132, 132, 1),
      //             size: Responsive.height(1.7, context),
      //           ),
               
      //         if (index != widget.navigationItems.length - 1)
      //         SizedBox(
      //           width: Responsive.width(4, context),
      //         ),
      //       ],
      //     );
      //   }).toList(),
      // ),
    );
  }
}