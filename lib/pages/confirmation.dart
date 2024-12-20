import 'package:flutter/material.dart';
import 'package:kriv/pages/homepage.dart';
import 'package:kriv/utilities/responsive.dart';

class Confirmation extends StatefulWidget {
  const Confirmation({Key? key}) : super(key: key);

  @override
  State<Confirmation> createState() => _ConfirmationState();
}

class _ConfirmationState extends State<Confirmation> {
  late String authToken;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      authToken = ModalRoute.of(context)?.settings.arguments as String;
      _navigateToHomeAfterDelay();
    });
  }

  void _navigateToHomeAfterDelay() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const HomePage(),
            settings: RouteSettings(arguments: authToken)
          ),
          (route) => false  // This removes all previous routes
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,  // Prevents back button press
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(
                  Responsive.width(10, context),
                  Responsive.height(5, context),
                  0,
                  0
                ),
                child: Image.asset('assets/images/myce_back_icon.png')
              ),
              SizedBox(
                height: Responsive.height(33, context),
              ),
              Container(
                alignment: Alignment.center,
                height: Responsive.height(20, context),
                padding: EdgeInsets.only(bottom: Responsive.height(2, context)),
                child: Image.asset('assets/images/engineer.png'),
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  'Our engineer will \ncontact you Soon!',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: Responsive.height(2.3, context),
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400
                  ),
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}