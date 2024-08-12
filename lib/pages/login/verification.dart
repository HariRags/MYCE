import 'dart:ui';
import 'package:kriv/pages/login/info_page.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter/material.dart';
import 'package:kriv/utilities/responsive.dart';

class Verification extends StatefulWidget {
  const Verification({Key? key}) : super(key: key);

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end:Alignment.topCenter,
            colors: [Color.fromRGBO(245, 237, 255, 1),Color.fromRGBO(255, 255, 255, 1)]
          )
        ),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          Container(
            margin: EdgeInsets.only(top:Responsive.height(20, context), bottom: Responsive.height(5, context)),
            child: Image.asset('assets/images/myce_logo.png'),
          ),
          Container(
            margin: EdgeInsets.only(bottom: Responsive.height(2, context)),
            padding: EdgeInsets.only(left:Responsive.width(5, context)),
            alignment: Alignment.centerLeft,
            child: Text('Verification code', style: TextStyle(color:const Color.fromRGBO(49, 49, 49, 1), fontFamily: 'Poppins',fontWeight:FontWeight.w600, fontSize: Responsive.height(2, context)  ),)
            ),
            Container(
              
            margin: EdgeInsets.only(bottom: Responsive.height(3, context)),
              padding: EdgeInsets.only(left:Responsive.width(5, context), right: Responsive.width(15, context)),
              alignment: Alignment.centerLeft,
              child:Text('Please enter the verification code sent to your phone or email', style: TextStyle(color:const Color.fromRGBO(102, 102, 102, 1), fontFamily: 'Poppins',fontWeight:FontWeight.w500, fontSize: Responsive.height(1.7, context)  ),)
             ,
            ),
            PinCodeTextField(
              length: 4,
              appContext: context,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              pinTheme: PinTheme(
                fieldHeight: Responsive.height(7, context),
                fieldWidth: Responsive.width(15, context),
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5),
                selectedColor: const Color.fromRGBO(107, 67, 151, 1),
                
                activeColor: const Color.fromRGBO(107, 67, 151, 1),
                inactiveColor: const Color.fromRGBO(107, 67, 151, 1),
                inactiveFillColor:const Color.fromRGBO(107, 67, 151, 1),
                selectedFillColor: const Color.fromRGBO(107, 67, 151, 1),

                
            )),
            SizedBox(height: Responsive.height(1, context),),
            Container(
              
            margin: EdgeInsets.only(bottom: Responsive.height(3, context)),
              padding: EdgeInsets.only(left:Responsive.width(5, context), right: Responsive.width(15, context)),
              alignment: Alignment.center,
              child:Text('Didn\'t receive the code? Resend', style: TextStyle(color:const Color.fromRGBO(102, 102, 102, 1), fontFamily: 'Poppins',fontWeight:FontWeight.w500, fontSize: Responsive.height(1.7, context)  ),)
             ,
            ),
            Container(
              margin: EdgeInsets.only(left: Responsive.width(5, context),right: Responsive.width(5, context)),
                width: Responsive.width(95, context),
                height: Responsive.height(6.5, context),
                child: FilledButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const InfoPage()),
                    );
                  },
                  child: Text(
                    'Verify otp',
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
         
        ],)
      ),
    );
  }
}
