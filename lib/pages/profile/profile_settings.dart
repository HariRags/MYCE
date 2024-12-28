import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kriv/pages/home.dart';
import 'package:kriv/pages/past_queries/queries_home.dart';
import 'package:kriv/pages/profile/contactus.dart';
import 'package:kriv/pages/profile/edit_profile.dart';
import 'package:kriv/utilities/global.dart';
import 'package:kriv/utilities/update_details.dart';

import 'package:kriv/widgets/myce_backbutton.dart';
import 'package:kriv/widgets/navigation.dart';
import 'package:kriv/utilities/responsive.dart';
import 'package:http/http.dart' as http;

class ProfileSettings extends StatefulWidget {
  final String? authToken;
  const ProfileSettings({Key? key,required this.authToken}) : super(key: key);

  @override
  State<ProfileSettings> createState() => ProfileSettingsState();
}

class ProfileSettingsState extends State<ProfileSettings> {
     void _showPrivacyPolicyDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: EdgeInsets.all(16),
            height: Responsive.height(80, context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Privacy Policy',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(fontSize: 16, color: Colors.black),
                        children: [
                          TextSpan(
                            text:
                                'Welcome to MYCE, a platform dedicated to providing engineering consulting services, enabling users to buy, sell, and rent properties and other real estate assets. This Privacy Policy explains how MYCE ("we," "us," or "our") collects, uses, discloses, and protects your personal information.\n\n',
                          ),
                          TextSpan(
                            text: '1. Information We Collect\n\n',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: 'We may collect the following types of information:\n\n',
                          ),
                          TextSpan(
                            text: 'a. Personal Information\n\n',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: '• Name, email address, phone number, and mailing address.\n',
                          ),
                          TextSpan(
                            text: '• Identification documents for verification purposes (if applicable).\n\n',
                          ),
                          TextSpan(
                            text: '2. How We Use Your Information\n\n',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: '• To verify user identity and prevent fraud.\n',
                          ),
                          TextSpan(
                            text: '• To comply with legal obligations.\n\n',
                          ),
                          TextSpan(
                            text: '3. Sharing Your Information\n\n',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: '• With Service Providers: To assist in providing services such as payment processing, customer support, and analytics.\n',
                          ),
                          TextSpan(
                            text: '• With Other Users: When engaging in transactions, certain information (e.g., your name and contact details) may be shared with other parties involved.\n',
                          ),
                          TextSpan(
                            text: '• For Legal Reasons: To comply with legal obligations, respond to lawful requests, or protect our rights and safety.\n',
                          ),
                          TextSpan(
                            text: '• With Your Consent: When you explicitly agree to share your information.\n\n',
                          ),
                          TextSpan(
                            text: '4. Data Protection\n\n',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: 'a. Security Measures\n',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: 'We implement robust security measures to protect your personal information, including encryption, secure servers, and access controls.\n\n',
                          ),
                          TextSpan(
                            text: 'b. Data Retention\n',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: 'We retain your information only for as long as necessary to fulfill the purposes outlined in this policy or as required by law.\n\n',
                          ),
                          TextSpan(
                            text: 'c. Your Rights\n',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: '• Access, correct, or delete your personal information.\n',
                          ),
                          TextSpan(
                            text: '• Object to or restrict certain data processing activities.\n',
                          ),
                          TextSpan(
                            text: '• Withdraw your consent for data processing where applicable.\n\n',
                          ),
                          TextSpan(
                            text: 'To exercise these rights, contact us at “email”.\n\n',
                          ),
                          TextSpan(
                            text: 'Changes to This Privacy Policy\n\n',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: 'We may update this Privacy Policy from time to time. Changes will be effective upon posting. We encourage you to review this policy periodically to stay informed.\n\n',
                          ),
                          TextSpan(
                            text: 'Contact Us\n\n',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: 'If you have any questions or concerns about this Privacy Policy or our data practices, please contact us at:\n',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Close'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
     void _showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          content: const Text('Do you really want to delete your account? Your data will be erased and this action is irreversible'),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop();
                deleteProfile();
              },
            ),
          ],
        );
      },
    );
  }
  void _showLogoutConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          content: const Text('Do you really want to logout your account?'),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () async{
                globals.accessToken = '';
        ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Profile Logged Out!"),
                                backgroundColor: Colors.green,
                              ),
                            );
                await globals.clearSharedPreferences();

                             Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const Home(),
                  settings: RouteSettings(arguments: globals.accessToken) // Replace with your next page
                ),
                (route) => false
              );
              },
            ),
          ],
        );
      },
    );
  }
  void deleteProfile()async{
    final String url = dotenv.env['SERVER_URL']!+'api/auth/delete_user/';
    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: {
          'Authorization': widget.authToken!, // Replace with your token if required
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 204) {
        
        globals.accessToken = '';
        ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Profile Deleted!"),
                                backgroundColor: Colors.green,
                              ),
                            );
                await globals.clearSharedPreferences();

                             Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const Home(),
                  settings: RouteSettings(arguments: globals.accessToken) // Replace with your next page
                ),
                (route) => false
              );
      } else if(response.statusCode == 401){

        await globals.clearSharedPreferences();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Session expired! Kingly login again."),
            backgroundColor: Colors.red,
          ),
        );

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => const Home(),
                settings: RouteSettings(
                    arguments:
                        globals.accessToken) // Replace with your next page
                ),
            (route) => false);
      
        
      }
    } catch (error) {
      print('Error deleting resource: $error');
    }
  }
  @override
  Widget build(BuildContext context) {
    String auth_token = widget.authToken!;
    
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const MYCEBackButton(),
            GestureDetector(
                onTap: () {},
                child: Card(
                  margin: EdgeInsets.only(
                      left: Responsive.width(4, context),
                      right: Responsive.width(4, context),
                      bottom: Responsive.height(2, context)),
                  elevation: 6,
                  surfaceTintColor: Colors.white,
                  color: Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: Responsive.height(13, context),
                        width: Responsive.width(20, context),
                        padding:
                            EdgeInsets.only(left: Responsive.width(5, context)),
                        child: CircleAvatar(
                          radius: 30.0,
                           backgroundImage: globals.profileImage != null
                              ? FileImage(globals.profileImage!)
                              : null,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          bottom: Responsive.height(1, context),
                        ),
                        width: Responsive.width(55, context),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                Responsive.width(4, context),
                                Responsive.height(2.5, context),
                                Responsive.width(5, context),
                                0,
                              ),
                              child:  Text(
                                globals.name,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.fromLTRB(
                                  Responsive.width(4, context),
                                  0,
                                  0,
                                  Responsive.height(0.6, context),
                                ),
                                child:  Text(
                                  globals.email,
                                  style: TextStyle(
                                    color: Color(0xFFB3B3B3),
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                    height: 0,
                                  ),
                                )),
                            Padding(
                                padding: EdgeInsets.fromLTRB(
                                  Responsive.width(4, context),
                                  0,
                                  0,
                                  Responsive.height(0.6, context),
                                ),
                                child: Text(
                                  globals.phoneNumber,
                                  style: TextStyle(
                                    color: Color(0xFFB3B3B3),
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                    height: 0,
                                  ),
                                ))
                          ],
                        ),
                      ),
                      Container(
                        child: TextButton(
                                  onPressed: () {
                                   
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => BlocProvider(
                                              create: (context) => UpdateBloc(auth_token),
                                              child: const EditProfile()),
                                        )
                                    );
                                  },
                                  child: const Text(
                                    'Edit',
                                    style: TextStyle(
                                      color: Color(0xFF6B4397),
                                      fontSize: 16,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      height: 0.09,
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      )),
                  Row(
                    children: [
                      SizedBox(
                        width: Responsive.width(100, context),
                        height: Responsive.height(20, context),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>  QueriesHome(),
                                        )
                                    );
                          },
                          child: Card(
                            margin: EdgeInsets.only(
                                left: Responsive.width(4, context),
                                right: Responsive.width(4, context),
                                bottom: Responsive.height(2, context)),
                            elevation: 6,
                            surfaceTintColor: Colors.white,
                            color: Colors.white,
                            child: Column(
                              children: [
                                SizedBox(height: Responsive.height(3, context)),
                                Image(
                                  image: AssetImage('assets/images/chat_bubble.png'),
                                  height: Responsive.height(8, context),
                                ),
                                const Text(
                                  'Past Enquiries',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      
                        
                      
                    ],
                  ),
                  SizedBox(
                    width: Responsive.width(100, context),
                    height: Responsive.height(22.5, context),
                    child: Card(
                      margin: EdgeInsets.only(
                          left: Responsive.width(4, context),
                          right: Responsive.width(4, context),
                          bottom: Responsive.height(2, context)),
                      elevation: 6,
                      surfaceTintColor: Colors.white,
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: Responsive.height(4, context)),
                          InkWell(
                            onTap: _showPrivacyPolicyDialog,
                            splashColor: Colors.transparent, // Disable splash color
                    highlightColor: Colors.transparent, 
                            child: Container(
                              // height:Responsive.height(5, context),
                              // width: Responsive.width(100, context),
                              child: Row(
                                children: [
                                  SizedBox(width: Responsive.width(8, context),),
                                  const Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Privacy Policy',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        'Important for both of us',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      )
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap:_showPrivacyPolicyDialog ,
                                    child: SizedBox(width: Responsive.width(35, context),)),
                                  const Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.black,
                                  )
                                ],
                              ),
                            ),
                          ),
                          Divider(
                            indent: Responsive.width(8, context),
                            endIndent: Responsive.width(8, context),
                            height: Responsive.height(4, context),
                          ),
                          InkWell(
                            onTap: () {
                                        Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ContactUs(), // Navigate to Contact Us page
                    ),
                                        );
                                      },

                            splashColor: Colors.transparent, // Disable splash color
                    highlightColor: Colors.transparent, 
                            child: Row(
                              children: [
                                SizedBox(width: Responsive.width(8, context),),
                                 Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Contact Us',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      'Important for both of us',
                                      style: TextStyle(
                                        color: Colors.black.withOpacity(0),
                                        fontSize: 12,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(width: Responsive.width(35, context),),
                                const Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.black,
                                )
                              ],
                            ),
                          ),
                          Divider(
                            indent: Responsive.width(8, context),
                            endIndent: Responsive.width(8, context),
                            height: Responsive.height(4, context),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: Responsive.height(1, context),
                  // ),
                  TextButton(
                    onPressed: _showLogoutConfirmationDialog,
                     
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(color: Color(0xFFE30000), width: 2),
                      )),
                      fixedSize: MaterialStateProperty.all<Size>(Size(
                          Responsive.width(93, context),
                          Responsive.height(7.2, context))),
                    ),
                    child: const Text(
                      "Log Out",
                      style: TextStyle(
                        color: Color(0xFFE30000),
                        fontSize: 20,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Responsive.height(2, context),
                  ),
                  TextButton(
                    onPressed: _showDeleteConfirmationDialog,
                     
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(color: Color(0xFFE30000), width: 2),
                      )),
                      fixedSize: MaterialStateProperty.all<Size>(Size(
                          Responsive.width(93, context),
                          Responsive.height(7.2, context))),
                    ),
                    child: const Text(
                      "Delete Account",
                      style: TextStyle(
                        color: Color(0xFFE30000),
                        fontSize: 20,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
        ),
      ),
    );
  }
}
