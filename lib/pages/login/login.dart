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
  
  // String? _phoneNumber;
  // String? _email;
  
  bool isEmail(String input) {
    // Check if it contains exactly one '@' and has a domain
    if (input.contains('@')&&input.contains('.')) {
      
          return true;
        
      
    }
    return false;
  }

  bool isPhoneNumber(String input) {
    // Check if it contains only digits and is exactly 10 characters long
    if (input.length == 10 && int.tryParse(input) != null) {
      return true;
    }
    return false;
  }
  
  void _submitInput(){

  }
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
    Map<String, String?> input_data = {'email': null, 'phone_number': null};  
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
                MaterialPageRoute(builder: (context) =>  Verification(input:input_data)),
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
                        onChanged: (value) {
                    print('hey2');
                    final input = value;
                    print(input);
                    if (isEmail(input)) {
                      print('emailyes');
                      print("Sending as email: $input");
                      input_data['email'] = input;
                    } else if (isPhoneNumber(input)) {
                      print('yo');
                      print("Sending as phone number: $input");
                      input_data['phone_number'] = input;
                    }else{
                      input_data['phone_number'] = null;
                      input_data['email'] = null;
                    }
                  
                        },
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
                      
                  // if (_formKey.currentState!.validate()) {
                  //   final input = _phoneController.text.trim();
                  //   print(input);
                  //   if (isEmail(input)) {
                  //     print("Sending as email: $input");
                  //     input_data['email'] = input;
                  //   } else if (isPhoneNumber(input)) {
                  //     print('yo');
                  //     print("Sending as phone number: $input");
                  //     input_data['phone_number'] = input;
                  //   }
                  // }
                  context.read<AuthBloc>().add(VerifyPhoneEvent(input_data));
                
                        // if (_formKey.currentState?.validate() ?? false) {
                          
                        //   final email = (_phoneController.text);
                        //   // _phoneNumber = BigInt.parse(_phoneController.text);

                        //   // print(phoneNumber); // Debug print
                        //   context.read<AuthBloc>().add(VerifyPhoneEvent(email));
            
                        // }
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
