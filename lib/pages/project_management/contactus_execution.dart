import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kriv/pages/confirmation.dart';
import 'package:kriv/pages/home.dart';
import 'package:kriv/pages/homepage.dart';
import 'package:kriv/utilities/contact_bloc.dart';
import 'package:kriv/utilities/execution_bloc.dart';
import 'package:kriv/utilities/global.dart';
import 'package:kriv/utilities/responsive.dart';
import 'package:kriv/utilities/swimming_bloc.dart';
import 'package:kriv/widgets/myce_backbutton.dart';
import 'package:kriv/widgets/navigation.dart';

class ContactUs extends StatefulWidget {
  final String? authToken;
  const ContactUs({Key? key, required this.authToken}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  String auth_token = "";
  late ContactBloc _contactBloc;
  @override
  void initState() {
    super.initState();
    // Access houseBloc from the context here
    // final contactBloc = BlocProvider.of<ContactBloc>(context);
    // auth_token = contactBloc.authToken;
    // _contactBloc = ContactBloc(auth_token);
  }

  final _formKey = GlobalKey<FormState>();
  final _phoneFormKey = GlobalKey<FormState>();
  final _emailFormKey = GlobalKey<FormState>();
  final _messageFormKey = GlobalKey<FormState>();

  String? _name;
  String? _phone;
  String? _email;
  String? _message;
  String? _report;

  // @override
  // void initState() {
  //   super.initState();
  //   // Initialize SignupBloc with widget.authToken

  //   final signupBloc = BlocProvider.of<SignupBloc>(context);
  //   authToken = signupBloc.authToken;
  //   _signupBloc = SignupBloc(authToken);
  // }
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
  bool isValidPhone(String input) {
  // Check if the input is exactly 10 characters and consists of only digits
  final RegExp phoneNumberRegex = RegExp(r'^\d{10}$');
  return phoneNumberRegex.hasMatch(input);
}
bool isValidEmail(String email) {
  final RegExp emailRegex = RegExp(
    r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z]{2,}$"
  );
  return emailRegex.hasMatch(email);
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
    if (_messageFormKey.currentState!.validate()) {
      _messageFormKey.currentState!.save();
    }
     
    
    if (_phone != null && !isValidPhone(_phone!)) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Phone number must be 10 digits'),
      backgroundColor: Colors.red,
    ),
  );
  return;
}

if (_email != null && !isValidEmail(_email!)) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Please enter a valid email'),
      backgroundColor: Colors.red,
    ),
  );
  return;
}
    final userData = {
      'full_name': _name,
      'first_name': _name,
      'last_name': _name,
      'phone_number': _phone,
      'email': _email,
      'message': _message,
      'report' : _report
    };
       String? errorMessage;
    for (var entry in userData.entries) {
      if (entry.value == null || entry.value.toString().trim().isEmpty) {
        errorMessage =
            'Enter all the details';
        break;
      }
    }

    if (errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
         
        ),
      );
      return;
    }
    _contactBloc.add(ContactSubmitEvent(userData));
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    
    String? authToken = args['auth_token'];
    auth_token = authToken!;
    _report = args['report'];
    _contactBloc = ContactBloc(auth_token);
    return Scaffold(
        body: BlocProvider(
      create: (context) => _contactBloc,
      child: BlocConsumer<ContactBloc, ContactState>(
        listenWhen: (previous, current) {
         return true; // You can add specific conditions here if needed
        },
        buildWhen: (previous, current) {
         return true; // You can add specific conditions here if needed
        },
        listener: (context, state) {
          
          if (state is ContactSubmittedState) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  // push to a contact us
                  builder: (context) => const Confirmation(),
                  settings: RouteSettings(
                      arguments: auth_token) // Replace with your next page
                  ),
            );
          } else if (state is ContactErrorState) {
           if (state.isSessionExpired) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => const Home(),
                    settings: RouteSettings(arguments: globals.accessToken)),
                (route) => false, // This will remove all previous routes
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
        
          }
        },
        builder: (context, state) {
          return SafeArea(
              child: Column(children: [
            const MYCEBackButton(),
            // const NavigationWidget(navigationItems: ['Project Management','Project Management Phase', 'Execution Phase']),
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
                      'Contact Us',
                      style: TextStyle(
                          fontFamily: 'Fraunces',
                          fontWeight: FontWeight.w600,
                          fontSize: Responsive.height(2.5, context)),
                    ),
                    SizedBox(
                      height: Responsive.height(1, context),
                    ),
                    Text(
                      'Please feel free to contact your civil engineer anytime. We will reach out to you as soon as possible.',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          fontSize: Responsive.height(1.5, context)),
                    ),
                    SizedBox(
                      height: Responsive.height(1.5, context),
                    ),
                    Text(
                      'Name',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: Responsive.height(2.5, context)),
                    ),
                    SizedBox(
                      height: Responsive.height(1, context),
                    ),
                    Container(
                        padding:
                            EdgeInsets.only(left: Responsive.width(2, context)),
                        height: Responsive.height(5, context),
                        alignment: Alignment.topLeft,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromRGBO(149, 149, 149, 1)),
                            borderRadius: BorderRadius.circular(6)),
                        child: Form(
                          key: _formKey,
                          child: TextFormField(
                              decoration: InputDecoration(
                                  // hintText: 'Name',
                                  hintStyle: const TextStyle(
                                    color: Color.fromRGBO(149, 149, 149, 1),
                                  ),
                                  contentPadding: EdgeInsets.only(
                                      left: Responsive.width(1, context),
                                      bottom: Responsive.height(1.2, context)),
                                  border: InputBorder.none),
                              validator: (value) => value!.isEmpty
                                  ? 'Please enter your name'
                                  : null,
                              onChanged: (value) {
                                
                                _name = value;
                              }),
                        )),
                    SizedBox(
                      height: Responsive.height(1.5, context),
                    ),
                    Text(
                      'E-mail',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: Responsive.height(2.5, context)),
                    ),
                    SizedBox(
                      height: Responsive.height(1, context),
                    ),
                    Container(
                        padding:
                            EdgeInsets.only(left: Responsive.width(2, context)),
                        height: Responsive.height(5, context),
                        alignment: Alignment.topLeft,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromRGBO(149, 149, 149, 1)),
                            borderRadius: BorderRadius.circular(6)),
                        child: Form(
                          key: _emailFormKey,
                          child: TextFormField(
                            decoration: InputDecoration(
                                // hintText: 'Email id',
                                hintStyle: const TextStyle(
                                  color: Color.fromRGBO(149, 149, 149, 1),
                                ),
                                contentPadding: EdgeInsets.only(
                                    left: Responsive.width(1, context),
                                    bottom: Responsive.height(1.2, context)),
                                border: InputBorder.none),
                            validator: (value) => value!.isEmpty
                                ? 'Please enter your email'
                                : null,
                            onChanged: (value) => _email = value,
                          ),
                        )),
                    SizedBox(
                      height: Responsive.height(1.5, context),
                    ),
                    Text(
                      'Phone Number',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: Responsive.height(2.5, context)),
                    ),
                    SizedBox(
                      height: Responsive.height(1, context),
                    ),
                    Container(
                        padding:
                            EdgeInsets.only(left: Responsive.width(2, context)),
                        height: Responsive.height(5, context),
                        alignment: Alignment.topLeft,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromRGBO(149, 149, 149, 1)),
                            borderRadius: BorderRadius.circular(6)),
                        child: Form(
                          key: _phoneFormKey,
                          child: TextFormField(
                            decoration: InputDecoration(
                                // hintText: 'Phone number',
                                hintStyle: const TextStyle(
                                  color: Color.fromRGBO(149, 149, 149, 1),
                                ),
                                contentPadding: EdgeInsets.only(
                                    left: Responsive.width(1, context),
                                    bottom: Responsive.height(1.2, context)),
                                border: InputBorder.none),
                            validator: (value) => value!.isEmpty
                                ? 'Please enter your phone number'
                                : null,
                            onChanged: (value) => _phone = value,
                          ),
                        )),
                    SizedBox(
                      height: Responsive.height(1.5, context),
                    ),
                    Text(
                      'Message',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: Responsive.height(2.5, context)),
                    ),
                    SizedBox(
                      height: Responsive.height(1, context),
                    ),
                    Container(
                        padding:
                            EdgeInsets.only(left: Responsive.width(2, context)),
                        height: Responsive.height(5, context),
                        alignment: Alignment.topLeft,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromRGBO(149, 149, 149, 1)),
                            borderRadius: BorderRadius.circular(6)),
                        child: Form(
                          key: _messageFormKey,
                          child: TextFormField(
                            decoration: InputDecoration(
                                // hintText: 'Message',
                                hintStyle: const TextStyle(
                                  color: Color.fromRGBO(149, 149, 149, 1),
                                ),
                                contentPadding: EdgeInsets.only(
                                    left: Responsive.width(1, context),
                                    bottom: Responsive.height(1.2, context)),
                                border: InputBorder.none),
                            validator: (value) => value!.isEmpty
                                ? 'Please enter your message'
                                : null,
                            onChanged: (value) => _message = value,
                          ),
                        )),
                    SizedBox(
                      height: Responsive.height(3, context),
                    ),
                    Container(
                      width: Responsive.width(95, context),
                      height: Responsive.height(6.5, context),
                      child: FilledButton(
                        onPressed: _submitForm,
                        child: Text(
                          'Done',
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
                    ),
                  ],
                ))
          ]));
        },
      ),
    ));
  }
}
