// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kriv/pages/homepage.dart';
import 'package:kriv/utilities/global.dart';
import 'package:kriv/utilities/responsive.dart';
import 'package:kriv/widgets/myce_backbutton.dart';
import 'package:kriv/widgets/navigation.dart';
import 'package:kriv/utilities/infopage_bloc.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({
    Key? key,
  }) : super(key: key);

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  String? authToken;
  late SignupBloc _signupBloc;

  final _formKey = GlobalKey<FormState>();
  final _phoneFormKey = GlobalKey<FormState>();
  final _emailFormKey = GlobalKey<FormState>();
  final _addressFormKey = GlobalKey<FormState>();

  String? _name;
  String? _phone;
  String? _email;
  String? _address;

  @override
  void initState() {
    super.initState();
    // Initialize SignupBloc with widget.authToken

    final signupBloc = BlocProvider.of<SignupBloc>(context);
    authToken = signupBloc.authToken;
    _signupBloc = SignupBloc(authToken);
  }
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
  

  void _submitForm() {
    // Validate and save all forms
    
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }
    if (_phoneFormKey.currentState!.validate()) {
      _phoneFormKey.currentState!.save();
    }
    if (_emailFormKey.currentState!.validate()) {
      _emailFormKey.currentState!.save();
    }
    if (_addressFormKey.currentState!.validate()) {
      _addressFormKey.currentState!.save();
    }

    

    final userData = {
      'full_name': _name,
      'first_name': _name,
      'last_name': _name,
      'phone_number': _phone,
      'email': _email,
      'address': _address,
    };
    
    if (isEmail(_email!) && isPhoneNumber(_phone!)) {
       _signupBloc.add(SubmitSignupEvent(userData));
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Kindly fill the details correctly"),
          backgroundColor: Colors.red,
        ),
      );
    }
   
  }

  @override
  Widget build(BuildContext context) {
    // 
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
            create: (context) => _signupBloc,
            child: BlocConsumer<SignupBloc, SignupState>(
              listenWhen: (previous, current) {
                
                return true; // You can add specific conditions here if needed
              },
              buildWhen: (previous, current) {
                 return true; // You can add specific conditions here if needed
              },
              listener: (context, state) {
               
                if (state is SignupSuccess) {
                 
                  String? auth_token = authToken;
                  
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomePage(),
                        settings: RouteSettings(arguments: auth_token)),
                  );
                } else if (state is SignupFailure) {
                  
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.error)),
                  );
                }
              },
              builder: (context, state) {
                return SafeArea(
                    child: Column(children: [
                  const MYCEBackButton(),
                  Container(
                      margin: EdgeInsets.only(
                        left: Responsive.width(3.5, context),
                        right: Responsive.width(3.5, context),
                      ),
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Add your info',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                fontSize: Responsive.height(2.5, context)),
                          ),
                          SizedBox(
                            height: Responsive.height(2, context),
                          ),
                          Container(
                              padding: EdgeInsets.only(
                                  left: Responsive.width(2, context)),
                              height: Responsive.height(5, context),
                              alignment: Alignment.topLeft,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color.fromRGBO(
                                          149, 149, 149, 1)),
                                  borderRadius: BorderRadius.circular(6)),
                              child: Form(
                                key: _formKey,
                                child: TextFormField(
                                    decoration: InputDecoration(
                                        hintText: 'Name',
                                        hintStyle: const TextStyle(
                                          color:
                                              Color.fromRGBO(149, 149, 149, 1),
                                        ),
                                        contentPadding: EdgeInsets.only(
                                            left: Responsive.width(1, context),
                                            bottom: Responsive.height(
                                                1.2, context)),
                                        border: InputBorder.none),
                                    validator: (value) => value!.isEmpty
                                        ? 'Please enter your name'
                                        : null,
                                    onChanged: (value) {
                                      
                                      _name = value;
                                      globals.name = value;
                                    }),
                              )),
                          SizedBox(
                            height: Responsive.height(3, context),
                          ),
                          Container(
                              padding: EdgeInsets.only(
                                  left: Responsive.width(2, context)),
                              height: Responsive.height(5, context),
                              alignment: Alignment.topLeft,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color.fromRGBO(
                                          149, 149, 149, 1)),
                                  borderRadius: BorderRadius.circular(6)),
                              child: Form(
                                key: _phoneFormKey,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      hintText: 'Phone number',
                                      hintStyle: const TextStyle(
                                        color:
                                            Color.fromRGBO(149, 149, 149, 1),
                                      ),
                                      contentPadding: EdgeInsets.only(
                                          left: Responsive.width(1, context),
                                          bottom: Responsive.height(
                                              1.2, context)),
                                      border: InputBorder.none),
                                  validator: (value) => value!.isEmpty
                                      ? 'Please enter your phone number'
                                      : null,
                                  onChanged: (value) {
                                    _phone = value;
                                    globals.phoneNumber = value;
                                    },
                                ),
                              )),
                          SizedBox(
                            height: Responsive.height(3, context),
                          ),
                          Container(
                              padding: EdgeInsets.only(
                                  left: Responsive.width(2, context)),
                              height: Responsive.height(5, context),
                              alignment: Alignment.topLeft,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color.fromRGBO(
                                          149, 149, 149, 1)),
                                  borderRadius: BorderRadius.circular(6)),
                              child: Form(
                                key: _emailFormKey,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      hintText: 'Email id',
                                      hintStyle: const TextStyle(
                                        color:
                                            Color.fromRGBO(149, 149, 149, 1),
                                      ),
                                      contentPadding: EdgeInsets.only(
                                          left: Responsive.width(1, context),
                                          bottom: Responsive.height(
                                              1.2, context)),
                                      border: InputBorder.none),
                                  validator: (value) => value!.isEmpty
                                      ? 'Please enter your email'
                                      : null,
                                  onChanged: (value) {
                                     _email = value;
                                     globals.email = value;
                                     },
                                ),
                              )),
                          SizedBox(
                            height: Responsive.height(3, context),
                          ),
                          Container(
                              padding: EdgeInsets.only(
                                  left: Responsive.width(2, context)),
                              height: Responsive.height(5, context),
                              alignment: Alignment.topLeft,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color.fromRGBO(
                                          149, 149, 149, 1)),
                                  borderRadius: BorderRadius.circular(6)),
                              child: Form(
                                key: _addressFormKey,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      hintText: 'Address',
                                      hintStyle: const TextStyle(
                                        color:
                                            Color.fromRGBO(149, 149, 149, 1),
                                      ),
                                      contentPadding: EdgeInsets.only(
                                          left: Responsive.width(1, context),
                                          bottom: Responsive.height(
                                              1.2, context)),
                                      border: InputBorder.none),
                                  validator: (value) => value!.isEmpty
                                      ? 'Please enter your address'
                                      : null,
                                  onChanged: (value) { 
                                    _address = value;
                                    globals.address = value;
                                    },
                                ),
                              )),
                          SizedBox(
                            height: Responsive.height(3, context),
                          ),
                          Container(
                            width: Responsive.width(95, context),
                            height: Responsive.height(6.5, context),
                            child: FilledButton(
                              onPressed: () {
                                _submitForm();
                                // handle api call for signup
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) => const HomePage()),
                                // );
                              },
                              child: Text(
                                'Done',
                                style: TextStyle(
                                    fontSize:
                                        Responsive.height(2.3, context)),
                              ),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  const Color.fromRGBO(107, 67, 151, 1),
                                ),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(13))),
                              ),
                            ),
                          )
                        ],
                      ))
                ]));
              },
            )),
      ),
    );
  }
}
