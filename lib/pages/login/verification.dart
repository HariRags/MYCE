import 'dart:async';
import 'dart:ui';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kriv/pages/homepage.dart';
import 'package:kriv/pages/login/info_page.dart';
import 'package:kriv/utilities/global.dart';
import 'package:kriv/utilities/infopage_bloc.dart';
import 'package:kriv/utilities/login_post.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter/material.dart';
import 'package:kriv/utilities/responsive.dart';
import 'package:kriv/utilities/verification_bloc.dart';

class Verification extends StatefulWidget {
  final Map<String,String?> input;

  Verification({Key? key, required this.input}) : super(key: key);
  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _otpController = TextEditingController();
  String? authToken;
  bool _canResend = true;
  bool _canVerify = true;
  int _timeLeft = 30;

  void startResendTimer() {
    setState(() {
      _canResend = false;
      _canVerify = true;
      _timeLeft = 30;
      _otpController.clear();
    });

    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeLeft > 0) {
          _timeLeft--;
        } else {
          _canResend = true;
          timer.cancel();
        }
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    final input = widget.input;
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
          listener: (context, state) async{
            print(
                'VerificationPage: BlocConsumer listener received state: $state');
            if (state is VerificationSuccess) {
              print(
                  'VerificationPage: Verification successful, navigating to home');
              // Store tokens in secure storage here if needed
              authToken = 'Bearer '+ state.accessToken;
              globals.accessToken = 'Bearer '+state.accessToken;
              globals.refreshToken =  'Bearer '+state.refreshToken;
              bool registered = state.registered;
              // After receiving the access token on login
              
    
              if(registered==true){
                globals.setAccessToken('Bearer '+state.accessToken);
                globals.setRefreshToken('Bearer '+state.refreshToken);
                print(state.userProfile);
                // globals.name = state.userProfile!['first_name'];
                globals.setName(state.userProfile!['first_name']);
                // globals.email = state.userProfile!['email'];
                globals.setEmail(state.userProfile!['email']);
                // globals.phoneNumber = state.userProfile!['phone_number'].toString();
                globals.setPhoneNumber(state.userProfile!['phone_number'].toString());
    
                 Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomePage(),
                        settings: RouteSettings(arguments: globals.accessToken)),
                        (route) => false,
                  );
              }else{
                 Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                        create: ((context) => SignupBloc(authToken)),
                        child:  InfoPage(input: input,)
                        ),
                  ),
                  (route) => false,
                  );
              }
              
            } else if (state is VerificationError) {
              _canVerify = true;
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
                          onChanged: (value) {
                        // Enable verify button if it was disabled and new OTP is being entered
                        if (!_canVerify && value.length > 0) {
                          setState(() {
                            _canVerify = true;
                          });
                        }
                      },
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
                      // color: Colors.amber,
                        margin: EdgeInsets.only(
                            bottom: Responsive.height(3, context)),
                        padding: EdgeInsets.only(
                            left: Responsive.width(18, context),
                            // right: Responsive.width(15, context)
                            ),
                        alignment: Alignment.center,
                        child: InkWell(
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Didn\'t receive the code?',
                                  style: TextStyle(
                                      color: const Color.fromRGBO(102, 102, 102, 1),
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      fontSize: Responsive.height(1.7, context)),
                                ),
                            SizedBox(
                      width: Responsive.width(2.5, context),
                    ),
                                 Text(
                            _canResend ? 'Resend' : 'Resend in $_timeLeft s',
                            style: TextStyle(
                              color: _canResend 
                                ? const Color.fromRGBO(107, 67, 151, 1)
                                : Colors.grey,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              fontSize: Responsive.height(1.7, context)
                            ),
                          ),
                              ],
                            ),
                            onTap: _canResend 
                        ? () {
                            context.read<AuthBloc>().add(VerifyPhoneEvent(input));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('OTP Sent!'),
                                backgroundColor: Colors.green,
                              ),
                            );
                            startResendTimer();
                          }
                        : null,
                            )),
                    Container(
                      margin: EdgeInsets.only(
                          left: Responsive.width(5, context),
                          right: Responsive.width(5, context)),
                      width: Responsive.width(95, context),
                      height: Responsive.height(6.5, context),
                      child: FilledButton(
                        onPressed: _canVerify 
                        ? () {
                            final otp = _otpController.text.trim();
                            if (otp.isNotEmpty && otp.length == 4) {
                              setState(() {
                                _canVerify = false;  // Disable verify button when clicked
                              });
                              context
                                  .read<VerificationBloc>()
                                  .add(VerifyOtpEvent(otp, input));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Please enter an OTP')),
                              );
                            }
                          }
                        : null,
                        child: Text(
                          'Verify otp',
                          style: TextStyle(
                              fontSize: Responsive.height(2.3, context)),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                          _canVerify
                            ? const Color.fromRGBO(107, 67, 151, 1)
                            : Colors.grey,
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
