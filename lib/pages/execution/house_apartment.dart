import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kriv/pages/confirmation.dart';
import 'package:kriv/pages/homepage.dart';
import 'package:kriv/utilities/global.dart';
import 'package:kriv/utilities/maps.dart';
import 'package:kriv/utilities/responsive.dart';
import 'package:kriv/widgets/imagepicker.dart';
import 'package:kriv/widgets/myce_backbutton.dart';
import 'package:kriv/widgets/navigation.dart';
import 'package:kriv/utilities/house_post.dart';
import 'package:file_picker/file_picker.dart';
class HouseApartment extends StatefulWidget {
  const HouseApartment({Key? key}) : super(key: key);

  @override
  State<HouseApartment> createState() => _HouseApartmentState();
}

class _HouseApartmentState extends State<HouseApartment> {
  String auth_token="";
  late HouseBloc _houseBloc;
  @override
  void initState() {
    super.initState();
    // Access houseBloc from the context here
    final houseBloc = BlocProvider.of<HouseBloc>(context);
    auth_token = houseBloc.authToken;
    _houseBloc = HouseBloc(auth_token);
  }
  
 
 // Provide your auth token here
  final _formKey = GlobalKey<FormState>();
  final _locationFormKey = GlobalKey<FormState>();
  final _planDetailsFormKey = GlobalKey<FormState>();
  final _floorPlanFormKey = GlobalKey<FormState>();
bool _isYesPressed = false;
  bool _isNoPressed = false;
  String? _location1;
  String? _location2;
  String? _planDetails;
  String? _digitalSurvey;
  File? _selectedFile;
  String? _floorPlan;
  String? _location;
  Future<void> selectFile() async {
    // Use the utility function to pick a file
    final result = await pickFile();

    if (result != null) {
      setState(() {
        _selectedFile = result['file'];
        _floorPlan = result['fileName'];
      });
    } else {
      setState(() {
        _selectedFile = null;
        _floorPlan = null;
        
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }
    if (_locationFormKey.currentState!.validate()) {
      _locationFormKey.currentState!.save();
    }
    if (_planDetailsFormKey.currentState!.validate()) {
      _planDetailsFormKey.currentState!.save();
    }

      print("submitted");
      final houseData = {
        'type': "apartment", 
        'location_line_1': _location1,
        'location_line_2' : _location2,
        "plan_details": _planDetails,
        "digital_survey": _digitalSurvey,
        "floor_plan": _selectedFile,
        "location":_location
      };
      _houseBloc.add(HouseSubmitEvent(houseData));
    
  }
  @override
  Widget build(BuildContext context) {
    print("hi");
    return Scaffold(
      body: BlocProvider(
        create: (context) => _houseBloc,
          child: BlocConsumer<HouseBloc,HouseState>(
            listenWhen: (previous, current) {
      print('HousePage: listenWhen called - Previous: $previous, Current: $current');
      return true; // You can add specific conditions here if needed
    },
    buildWhen: (previous, current) {
      print('HousePage: buildWhen called - Previous: $previous, Current: $current');
      return true; // You can add specific conditions here if needed
    },
    listener: (context, state) {
      print('HousePage: BlocConsumer listener received state: $state');

      if (state is HouseSubmittedState) {
        print('HousePage: House submission successful, navigating to next page');
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
            builder: (context) =>  const Confirmation(),
            settings: RouteSettings(arguments: auth_token) // Replace with your next page
          ),
        );
      } else if (state is HouseErrorState) {
        print('HousePage: Showing error snackbar');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.message),
            backgroundColor: Colors.red,
          ),
        );
      }
    },
            builder: (context,state){
              return SafeArea(
                  child: Column(children: [
                      const MYCEBackButton(),
                      const NavigationWidget(navigationItems: ['Execution', 'House', 'Apartment']),
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
                      'Location',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: Responsive.height(2.5, context)),
                    ),
                     
                    InkWell(
                      onTap: () async {
                        final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MapPage(),
                              ),
                            );
                            if (result != null && result is String) {
                              setState(() {
                                _location = result;
                              });
                            }
                            print(result);
              
                      },
                      child: Container(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  size: Responsive.height(2, context),
                                  color: const Color.fromRGBO(107, 67, 151, 1),
                                ),
                                Text(
                                    (_location == null)
                                        ? 'Select the location'
                                        : _location!,
                                    style: TextStyle(
                                        fontSize:
                                            Responsive.height(1.5, context),
                                        color: Colors.black)),
                              ],
                            ),
                          ),
                    ),
                    SizedBox(
                      height: Responsive.height(1, context),
                    ),
                    Container(
                        padding: EdgeInsets.only(left: Responsive.width(2, context)),
                        height: Responsive.height(4.5, context),
                        alignment: Alignment.topLeft,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: const Color.fromRGBO(149, 149, 149, 1)),
                            borderRadius: BorderRadius.circular(6)),
                        child: Form(
                          key: _formKey,
                          child: TextFormField(
                            decoration: InputDecoration(
                                hintText: 'House/ Flat/ Block Number',
                                hintStyle: TextStyle(
                                  color: const Color.fromRGBO(132, 132, 132, 1),
                                  fontSize: Responsive.height(1.6, context),
                                  fontWeight: FontWeight.w400,
                                ),
                                contentPadding: EdgeInsets.only(
                                    left: Responsive.width(1, context),
                                    bottom: Responsive.height(1.2, context)),
                                border: InputBorder.none),
                                onSaved: (value) {
                                  _location1 = value;
                                }
                          ),
                        )),
                    SizedBox(
                      height: Responsive.height(0.5, context),
                    ),
                    Container(
                        padding: EdgeInsets.only(left: Responsive.width(2, context)),
                        height: Responsive.height(4.5, context),
                        alignment: Alignment.topLeft,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: const Color.fromRGBO(149, 149, 149, 1)),
                            borderRadius: BorderRadius.circular(6)),
                        child: Form(
                          key: _locationFormKey,
                          child: TextFormField(
                            decoration: InputDecoration(
                                hintText: 'Area/ Landmark/ Road',
                                hintStyle: TextStyle(
                                  color: const Color.fromRGBO(132, 132, 132, 1),
                                  fontSize: Responsive.height(1.6, context),
                                  fontWeight: FontWeight.w400,
                                ),
                                contentPadding: EdgeInsets.only(
                                    left: Responsive.width(1, context),
                                    bottom: Responsive.height(1.2, context)),
                                border: InputBorder.none),
                                onSaved: (value) {
                                  _location2 = value;
                                }
                          ),
                        )),
                    SizedBox(
                      height: Responsive.height(2.2, context),
                    ),
                    Text(
                      'Plan Details',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: Responsive.height(2.5, context)),
                    ),
                    SizedBox(
                      height: Responsive.height(1, context),
                    ),
                    Container(
                        padding: EdgeInsets.only(left: Responsive.width(2, context)),
                        height: Responsive.height(5, context),
                        alignment: Alignment.topLeft,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: const Color.fromRGBO(149, 149, 149, 1)),
                            borderRadius: BorderRadius.circular(6)),
                        child: Form(
                          key: _planDetailsFormKey,
                          child: TextFormField(
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    left: Responsive.width(1, context),
                                    bottom: Responsive.height(1.2, context)),
                                border: InputBorder.none),
                                onSaved: (value) {
                                  _planDetails = value;
                                }
                          ),
                        )),
                    SizedBox(
                      height: Responsive.height(2.2, context),
                    ),
                    Text(
                      'Digital Survey',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: Responsive.height(2.5, context)),
                    ),
                    SizedBox(
                      height: Responsive.height(1, context),
                    ),
                    Row(
                      children: [
                        Container(
                          height: Responsive.height(5.5, context),
                          width: Responsive.width(45, context),
                          child: OutlinedButton(
                            onPressed: () {
                              setState(() {
                _digitalSurvey = "true";
                _isYesPressed = true;
                _isNoPressed = false;
              });
                            },
                            child: Center(
                              child: Text('Yes',
                                  style: TextStyle(
                                      fontSize: Responsive.height(2.5, context))),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                if (_isYesPressed ) {
                                  return Colors.purple; // Border color when button is pressed
                                }
                                return Colors.white; // Transparent border when button is not pressed
                              }),
                              
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                                  foregroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                if (_isYesPressed) {
                  return Colors.white; // Text color when button is pressed
                }
                return Color(0xFF6B4397); // Text color when button is not pressed
              }),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: Responsive.width(2, context),
                        ),
                        Container(
                          height: Responsive.height(5.5, context),
                          width: Responsive.width(45, context),
                          child: OutlinedButton(
                            onPressed: () {
                             setState(() {
                _digitalSurvey = "false";
                _isYesPressed = false;
                _isNoPressed = true;
              });
                            },
                            child: Center(
                              child: Text('No',
                                  style: TextStyle(
                                      fontSize: Responsive.height(2.5, context))),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                 if (_isNoPressed) {
                                  return Colors.purple; // Border color when button is pressed
                                }
                                return Colors.white; // Transparent border when button is not pressed
                              }),
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                                   foregroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                if (_isNoPressed) {
                  return Colors.white; // Text color when button is pressed
                }
                return Color(0xFF6B4397); // Text color when button is not pressed
              }),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Responsive.height(2.5, context),
                    ),
                    Text(
                      'Upload Floor Plan',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: Responsive.height(2.5, context)),
                    ),
                    SizedBox(
                      height: Responsive.height(1, context),
                    ),
                    InkWell(
                      onTap: selectFile,
                      child: Container(
                          padding: EdgeInsets.only(left: Responsive.width(3, context),right: Responsive.width(2, context),top: Responsive.width(2, context)),
                          height: Responsive.height(5, context),
                          alignment: Alignment.topLeft,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color.fromRGBO(149, 149, 149, 1)),
                              borderRadius: BorderRadius.circular(6)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: Responsive.width(75, context),
                                child: _selectedFile != null
                                        ? Row(
                                            children: [
                                              if (_selectedFile!.path
                                                  .endsWith('.pdf'))
                                                Icon(
                                                  Icons.picture_as_pdf,
                                                  size: 100,
                                                  // color: Colors.red,
                                                )
                                              else
                                                Icon(
                                                 Icons.image,
                                                
                                                ),
                                              SizedBox(height: 10),
                                              Text(
                                                'File Selected',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500),
                                                    overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          )
                                        : Text(
                                  '.pdf/.jpg/.png',
                                  style: TextStyle(
                                          color: const Color.fromRGBO(0, 0, 0, 1),
                                          fontSize: Responsive.height(1.6, context),
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.italic),
                                  textAlign: TextAlign.left 
                                ),
                              ),
                              // Text(
                              //   '.pdf/.jpg/.png',
                              //   style: TextStyle(
                              //           color: const Color.fromRGBO(0, 0, 0, 1),
                              //           fontSize: Responsive.height(1.6, context),
                              //           fontWeight: FontWeight.w400,
                              //           fontStyle: FontStyle.italic),
                              //   textAlign: TextAlign.left 
                              // ),
                               Icon(
                                      Icons.file_upload_outlined, // Use Icons.camera_alt for a camera icon
                                      // size: Responsive.height(1,context),          // Adjust size as needed
                                      color: Colors.black, // Customize the color
                                    )
                      
                            ],
                          )),
                    ),
                    SizedBox(
                      height: Responsive.height(3, context),
                    ),
                    Container(
                      width: Responsive.width(95, context),
                      height: Responsive.height(6.5, context),
                      child: FilledButton(
                        onPressed:  _submitForm,
                        child: Text(
                          'Done',
                          style: TextStyle(fontSize: Responsive.height(2.3, context)),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            const Color.fromRGBO(107, 67, 151, 1),
                          ),
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13))),
                        ),
                      ),
                    )
                  ],
                ))
                    ]));
  },
          )),
    );
  }
}
