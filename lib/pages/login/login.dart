import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kriv/pages/login/verification.dart';
import 'package:kriv/utilities/responsive.dart';
import 'package:kriv/utilities/login_post.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  late final AuthBloc _authBloc;
  BigInt? _phoneNumber = BigInt.parse("1234567890");
  String? email;
  @override
  void initState() {
    super.initState();
    _authBloc = AuthBloc();
  }

  @override
  void dispose() {
    _authBloc.close();
    _phoneController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider.value(
        value: _authBloc,
        child: BlocConsumer<AuthBloc, AuthState>(
          listenWhen: (previous, current) {
            print('LoginPage: listenWhen called - Previous: $previous, Current: $current');
            return true; // You can add conditions here if needed
          },
          buildWhen: (previous, current) {
            print('LoginPage: buildWhen called - Previous: $previous, Current: $current');
            return true; // You can add conditions here if needed
          },
           listener: (context, state) {
            print('LoginPage: BlocConsumer listener received state: $state');
            if (state is AuthSuccess) {
              print('LoginPage: Navigating to Verification page');
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  Verification(phoneNumber: _phoneNumber)),
              );
            } else if (state is AuthError) {
              print('LoginPage: Showing error snackbar');
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context,state){
            return Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Color.fromRGBO(245, 237, 255, 1),
                    Color.fromRGBO(255, 255, 255, 1),
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: Responsive.height(20, context),
                      bottom: Responsive.height(5, context),
                    ),
                    child: Image.asset('assets/images/myce_logo.png'),
                  ),
                  Container(
                    margin:
                        EdgeInsets.only(bottom: Responsive.height(2, context)),
                    padding: EdgeInsets.only(left: Responsive.width(5, context)),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Login or Sign up',
                      style: TextStyle(
                        color: const Color.fromRGBO(49, 49, 49, 1),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: Responsive.height(2, context),
                      ),
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.only(bottom: Responsive.height(2, context)),
                    padding: EdgeInsets.only(
                      left: Responsive.width(5, context),
                      right: Responsive.width(15, context),
                    ),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Enter email or phone number to get one time otp',
                      style: TextStyle(
                        color: const Color.fromRGBO(102, 102, 102, 1),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: Responsive.height(1.7, context),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: Responsive.width(5, context),
                      right: Responsive.width(5, context),
                      bottom: Responsive.height(3, context),
                    ),
                    padding: EdgeInsets.only(left: Responsive.width(2, context)),
                    height: Responsive.height(5, context),
                    alignment: Alignment.topLeft,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromRGBO(149, 149, 149, 1)),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: _phoneController,
                        decoration: InputDecoration(
                          hintText: 'Email id or phone number',
                          hintStyle: TextStyle(
                            color: const Color.fromRGBO(17, 17, 19, 0.6),
                            fontSize: Responsive.height(1.8, context),
                            fontWeight: FontWeight.w400,
                          ),
                          contentPadding: EdgeInsets.only(
                            left: Responsive.width(1, context),
                            bottom: Responsive.height(1.2, context),
                          ),
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field cannot be empty';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: Responsive.width(5, context),
                      right: Responsive.width(5, context),
                    ),
                    width: Responsive.width(95, context),
                    height: Responsive.height(6.5, context),
                    child: FilledButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          
                          final email = (_phoneController.text);
                          // _phoneNumber = BigInt.parse(_phoneController.text);

                          // print(phoneNumber); // Debug print
                          context.read<AuthBloc>().add(VerifyPhoneEvent(email));
            
                        }
                      },
                      child: Text(
                        'Get otp',
                        style:
                            TextStyle(fontSize: Responsive.height(2.3, context)),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          const Color.fromRGBO(107, 67, 151, 1),
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
        },
        ),
      ),
    );
  }
}
