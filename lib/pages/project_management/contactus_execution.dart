import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kriv/pages/confirmation.dart';
import 'package:kriv/pages/homepage.dart';
import 'package:kriv/utilities/contact_bloc.dart';
import 'package:kriv/utilities/execution_bloc.dart';
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

  void _submitForm() {
    // Validate and save all forms
    print("hi");
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

    print("submitted");

    final userData = {
      'full_name': _name,
      'first_name': _name,
      'last_name': _name,
      'phone_number': _phone,
      'email': _email,
      'message': _message,
      'report' : _report
    };
    print(userData);
    _contactBloc.add(ContactSubmitEvent(userData));
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    print('HomePage: Retrieved arguments: $args');
    String? authToken = args['auth_token'];
    auth_token = authToken!;
    _report = args['report'];
    _contactBloc = ContactBloc(auth_token);
    return Scaffold(
        body: BlocProvider(
      create: (context) => _contactBloc,
      child: BlocConsumer<ContactBloc, ContactState>(
        listenWhen: (previous, current) {
          print(
              'HousePage: listenWhen called - Previous: $previous, Current: $current');
          return true; // You can add specific conditions here if needed
        },
        buildWhen: (previous, current) {
          print(
              'HousePage: buildWhen called - Previous: $previous, Current: $current');
          return true; // You can add specific conditions here if needed
        },
        listener: (context, state) {
          print('HousePage: BlocConsumer listener received state: $state');

          if (state is ContactSubmittedState) {
            print(
                'HousePage: House submission successful, navigating to next page');
            // Show success message
            // ScaffoldMessenger.of(context).showSnackBar(
            //   const SnackBar(
            //     content: Text('House submitted successfully!'),
            //     backgroundColor: Colors.green,
            //   ),
            // );
            // Navigate to next page
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
            print('HousePage: Showing error snackbar');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
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
                                print(value);
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
