import 'dart:ui';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kriv/pages/login/info_page.dart';
import 'package:kriv/utilities/infopage_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter/material.dart';
import 'package:kriv/utilities/responsive.dart';
import 'package:kriv/utilities/verification_bloc.dart';

class Verification extends StatefulWidget {
  final BigInt? phoneNumber;

  Verification({Key? key, required this.phoneNumber}) : super(key: key);
  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _otpController = TextEditingController();
  String? authToken;
  @override
  Widget build(BuildContext context) {
    final phoneNumber = widget.phoneNumber;
    return Scaffold(
      body: BlocProvider(
        create: (context) => VerificationBloc(),
        child: BlocConsumer<VerificationBloc, VerificationState>(
          listenWhen: (previous, current) {
            print(
                'VerificationPage: listenWhen called - Previous: $previous, Current: $current');
            return true; // You can add specific conditions here if needed
          },
          buildWhen: (previous, current) {
            print(
                'VerificationPage: buildWhen called - Previous: $previous, Current: $current');
            return true; // You can add specific conditions here if needed
          },
          listener: (context, state) {
            print(
                'VerificationPage: BlocConsumer listener received state: $state');
            if (state is VerificationSuccess) {
              print(
                  'VerificationPage: Verification successful, navigating to home');
              // Store tokens in secure storage here if needed
              authToken = state.accessToken;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                        create: ((context) => SignupBloc(authToken)),
                        child: InfoPage()
                        ),
                  ));
            } else if (state is VerificationError) {
              print('VerificationPage: Showing error snackbar');
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            return Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                      Color.fromRGBO(245, 237, 255, 1),
                      Color.fromRGBO(255, 255, 255, 1)
                    ])),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          top: Responsive.height(20, context),
                          bottom: Responsive.height(5, context)),
                      child: Image.asset('assets/images/myce_logo.png'),
                    ),
                    Container(
                        margin: EdgeInsets.only(
                            bottom: Responsive.height(2, context)),
                        padding:
                            EdgeInsets.only(left: Responsive.width(5, context)),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Verification code',
                          style: TextStyle(
                              color: const Color.fromRGBO(49, 49, 49, 1),
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: Responsive.height(2, context)),
                        )),
                    Container(
                      margin: EdgeInsets.only(
                          bottom: Responsive.height(3, context)),
                      padding: EdgeInsets.only(
                          left: Responsive.width(5, context),
                          right: Responsive.width(15, context)),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Please enter the verification code sent to your phone or email',
                        style: TextStyle(
                            color: const Color.fromRGBO(102, 102, 102, 1),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            fontSize: Responsive.height(1.7, context)),
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: PinCodeTextField(
                          controller: _otpController,
                          length: 4,
                          appContext: context,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          pinTheme: PinTheme(
                            fieldHeight: Responsive.height(7, context),
                            fieldWidth: Responsive.width(15, context),
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(5),
                            selectedColor:
                                const Color.fromRGBO(107, 67, 151, 1),
                            activeColor: const Color.fromRGBO(107, 67, 151, 1),
                            inactiveColor:
                                const Color.fromRGBO(107, 67, 151, 1),
                            inactiveFillColor:
                                const Color.fromRGBO(107, 67, 151, 1),
                            selectedFillColor:
                                const Color.fromRGBO(107, 67, 151, 1),
                          )),
                    ),
                    SizedBox(
                      height: Responsive.height(1, context),
                    ),
                    Container(
                        margin: EdgeInsets.only(
                            bottom: Responsive.height(3, context)),
                        padding: EdgeInsets.only(
                            left: Responsive.width(5, context),
                            right: Responsive.width(15, context)),
                        alignment: Alignment.center,
                        child: FilledButton(
                            child: Text(
                              'Didn\'t receive the code? Resend',
                              style: TextStyle(
                                  color: const Color.fromRGBO(102, 102, 102, 1),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  fontSize: Responsive.height(1.7, context)),
                            ),
                            onPressed: () {
                              // verify_phone api call, if success then navigate to info page
                            })),
                    Container(
                      margin: EdgeInsets.only(
                          left: Responsive.width(5, context),
                          right: Responsive.width(5, context)),
                      width: Responsive.width(95, context),
                      height: Responsive.height(6.5, context),
                      child: FilledButton(
                        onPressed: () {
                          final otp = _otpController.text.trim();
                          if (otp.isNotEmpty) {
                            context
                                .read<VerificationBloc>()
                                .add(VerifyOtpEvent(otp, phoneNumber));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Please enter an OTP')),
                            );
                          }
                        },
                        child: Text(
                          'Verify otp',
                          style: TextStyle(
                              fontSize: Responsive.height(2.3, context)),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            const Color.fromRGBO(107, 67, 151, 1),
                          ),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(13))),
                        ),
                      ),
                    )
                  ],
                ));
          },
        ),
      ),
    );
  }
}
