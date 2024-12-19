import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kriv/pages/homepage.dart';
import 'package:kriv/pages/profile/profile_settings.dart';
import 'package:kriv/utilities/global.dart';
import 'package:kriv/utilities/responsive.dart';
import 'package:kriv/utilities/update_details.dart';

import 'package:kriv/widgets/myce_backbutton.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => EditProfileState();
}

class EditProfileState extends State<EditProfile> {
  String? authToken;
  late UpdateBloc _updateBloc;
  String? _name;
  String? _phone;
  String? _email;

  final _formKey = GlobalKey<FormState>();
  final _phoneFormKey = GlobalKey<FormState>();
  final _emailFormKey = GlobalKey<FormState>();

  final TextEditingController _controllerMail = TextEditingController();
  final TextEditingController _controllerNumber = TextEditingController();
  final TextEditingController _controllerName = TextEditingController();

  final picker = ImagePicker();
  File? file;
  XFile? pickedImage;
  bool isEmail(String? email){
    if (email!.contains('@')&&email!.contains('.')) {
      
          return true;
        
      
    }
    return false;
  }
  bool isPhone(String? phone){
    if (phone!.length == 10 && int.tryParse(phone) != null) {
      return true;
    }
    return false;
  }
  @override
  void initState() {
    super.initState();
    // Initialize SignupBloc with widget.authToken

    final updateBloc = BlocProvider.of<UpdateBloc>(context);
    authToken = updateBloc.authToken;
    _updateBloc = UpdateBloc(authToken);
  }
  void _submitForm() {
    // Validate and save all forms
    print("hi");
    

    print("submitted");

    final userData = {
      'full_name': _name,
      'first_name': _name,
      'last_name': _name,
      'name': _name,
      'phone_number': _phone,
      'email': _email,
    };
    print(userData);
    _updateBloc.add(SubmitUpdateEvent(userData));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => _updateBloc,
        child: BlocConsumer<UpdateBloc,UpdateState>(
           listenWhen: (previous, current) {
                print(
                    'SignupPage: listenWhen called - Previous: $previous, Current: $current');
                return true; // You can add specific conditions here if needed
              },
              buildWhen: (previous, current) {
                print(
                    'SignupPage: buildWhen called - Previous: $previous, Current: $current');
                return true; // You can add specific conditions here if needed
              },
              listener: (context, state) {
                print(
                    'SignupPage: BlocConsumer listener received state: $state');

                if (state is UpdateSuccess) {
                  print(
                      'SignupPage: Signup successful, navigating to next page');
                  print(authToken);
                  String? auth_token = authToken;
                  print(
                      'SignupPage: Before navigation - authToken: $authToken');
                  print(
                      'SignupPage: Before navigation - auth_token: $auth_token');
                  print(state.userProfile); 
                  // globals.name = state.userProfile!['full_name'];
                  globals.setName(state.userProfile!['full_name']);
                  // globals.email = state.userProfile!['email'];
                  globals.setEmail(state.userProfile!['email']);
                  // globals.phoneNumber = state.userProfile!['phone_number'].toString();
                  globals.setPhoneNumber(state.userProfile!['phone_number'].toString());
                  
                  ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Profile Updated"),
                                backgroundColor: Colors.green,
                              ),
                            );
                            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                  settings: RouteSettings(arguments: globals.accessToken) // Replace with your next page
                ),
              );

                } else if (state is UpdateFailure) {
                  print('SignupPage: Showing error snackbar');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.error)),
                  );
                }
              },

          builder: (context,state){
            return SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const MYCEBackButton(),
                  Container(
                    margin: EdgeInsets.only(
                        left: Responsive.width(5, context),
                        top: Responsive.height(3, context)),
                    child: const Text(
                      'Edit Profile',
                      style: TextStyle(
                        color: Color(0xFF303030),
                        fontSize: 20,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        height: 0.10,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Responsive.height(4, context),
                  ),
                  Center(
                    child: Stack(children: <Widget>[
                      const CircleAvatar(
                        radius: 60.0,
                      ),
                      Positioned(
                        top: 0.0,
                        right: -13,
                        child: InkWell(
                          onTap: () async {
                            pickedImage =
                                await picker.pickImage(source: ImageSource.gallery);
                            setState(() {
                              file = File(pickedImage!.path);
                            });
                          },
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.mode_edit_outline_outlined,
                              size: 30,
                            ),
                            color: const Color(0xFF6B4397),
                          ),
                        ),
                      ),
                    ]),
                  ),
                  Container(
                    height: Responsive.height(10.5, context),
                    margin: EdgeInsets.only(
                        top: Responsive.height(3, context),
                        left: Responsive.width(5, context)),
                    child: ListView(
                      padding: EdgeInsets.only(right: Responsive.width(5, context)),
                      children: [
                        const Text(
                          //label
                          'Name',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextField(
                          keyboardType: TextInputType.name,
                          controller: _controllerName,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 2, color: Color(0x33111112)),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 2, color: Color(0x33111112)),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          style: const TextStyle(
                            color: Color(0x99111112),
                            fontSize: 17,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: Responsive.height(10.5, context),
                    margin: EdgeInsets.only(
                        top: Responsive.height(3, context),
                        left: Responsive.width(5, context)),
                    child: ListView(
                      padding: EdgeInsets.only(right: Responsive.width(5, context)),
                      children: [
                        const Text(
                          //label
                          'Phone Number',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextField(
                          keyboardType: TextInputType.number,
                          controller: _controllerNumber,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 2, color: Color(0x33111112)),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 2, color: Color(0x33111112)),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          style: const TextStyle(
                            color: Color(0x99111112),
                            fontSize: 17,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: Responsive.height(10.5, context),
                    margin: EdgeInsets.only(
                        top: Responsive.height(3, context),
                        left: Responsive.width(5, context)),
                    child: ListView(
                      padding: EdgeInsets.only(right: Responsive.width(5, context)),
                      children: [
                        const Text(
                          //label
                          'Email ID',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _controllerMail,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 2, color: Color(0x33111112)),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 2, color: Color(0x33111112)),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          style: const TextStyle(
                            color: Color(0x99111112),
                            fontSize: 17,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Responsive.height(3, context),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          if (isEmail(_controllerMail.text.trim()) &&
                              isPhone(_controllerNumber.text.trim()) &&
                              _controllerName.text.trim().isNotEmpty) {
                                
                            _name = _controllerName.text.trim();
                            _phone = _controllerNumber.text.trim();
                            _email = _controllerMail.text.trim();
                            _submitForm();
                            
                          }else{
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Kindly fill the details correctly"),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                          
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(const Color(0xFF6B4397)),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14))),
                          fixedSize: MaterialStateProperty.all<Size>(Size(
                              Responsive.width(90, context),
                              Responsive.height(7.2, context))),
                        ),
                        child: const Text(
                          'Save',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            height: 0.07,
                          ),
                        ),
                      )
                    ],
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
