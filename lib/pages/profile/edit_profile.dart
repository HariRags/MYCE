import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kriv/pages/home.dart';
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

  final ImagePicker _picker = ImagePicker();
  File? _imageFile;
  String? _imagePath;
  String? _base64Image;


  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1800,
      );
      
      if (pickedFile != null) {
        final File imageFile = File(pickedFile.path);
        final List<int> imageBytes = await imageFile.readAsBytes();
        final String base64Image = base64Encode(imageBytes);
        
        setState(() {
          _imageFile = File(pickedFile.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error picking image'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
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
     _controllerName.text = globals.name;
    _controllerMail.text = globals.email;
    _controllerNumber.text = globals.phoneNumber;
    if (globals.profileImage !=null) {
      _imageFile = globals.profileImage;
    }
  }
  void _submitForm() {
    // Validate and save all forms
    
    

    

    final userData = {
      'full_name': _name,
      'first_name': _name,
      'last_name': _name,
      'name': _name,
      'phone_number': _phone,
      'email': _email,
      'profile_picture':_imageFile
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
    _updateBloc.add(SubmitUpdateEvent(userData));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => _updateBloc,
        child: BlocConsumer<UpdateBloc,UpdateState>(
           listenWhen: (previous, current) {
                return true; // You can add specific conditions here if needed
              },
              buildWhen: (previous, current) {
               return true; // You can add specific conditions here if needed
              },
              listener: (context, state) {
                
                if (state is UpdateSuccess) {
                
                  String? auth_token = authToken;
                
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
                   if (state.isSessionExpired) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.error),
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
                    content: Text("Enter all deatils"),
                    backgroundColor: Colors.red,
                  ),
                );
              }
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
                    child: Stack(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 60.0,
                             backgroundImage: _imageFile != null
                              ? FileImage(_imageFile!)
                              : null,
                          ),
                          Positioned(
                            top: 0,
                            right: -13,
                            child: IconButton(
                              onPressed: _pickImage,
                              icon: const Icon(
                                Icons.mode_edit_outline_outlined,
                                size: 30,
                                color: Color(0xFF6B4397),
                              ),
                            ),
                          ),
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
