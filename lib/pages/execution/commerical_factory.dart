import 'package:flutter/material.dart';
import 'package:kriv/pages/confirmation.dart';
// import 'package:kriv/pages/execution/commercial.dart';
import 'package:kriv/pages/homepage.dart';
import 'package:kriv/utilities/commercial_bloc.dart';
import 'package:kriv/utilities/responsive.dart';
import 'package:kriv/widgets/imagepicker.dart';
import 'package:kriv/widgets/myce_backbutton.dart';
import 'package:kriv/widgets/navigation.dart';
// import 'package:kriv/utilities/commercial_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class CommercialFactory extends StatefulWidget {
  const CommercialFactory({Key? key}) : super(key: key);

  @override
  State<CommercialFactory> createState() => _CommercialFactoryState();
}

class _CommercialFactoryState extends State<CommercialFactory> {
  String auth_token = "";
  late CommercialBloc _commercialBloc;

  @override
  void initState() {
    super.initState();
    // Access industryBloc from the context here
    final commercialBloc = BlocProvider.of<CommercialBloc>(context);
    auth_token = commercialBloc.authToken;
    _commercialBloc = CommercialBloc(auth_token);
  }

  final _formKey = GlobalKey<FormState>();
  final _locationFormKey = GlobalKey<FormState>();
  final _planDetailsFormKey = GlobalKey<FormState>();
  final _floorPlanFormKey = GlobalKey<FormState>();

  String? _location1;
  String? _location2;
  String? _planDetails;
  String? _digitalSurvey;
  String? _floorPlan;
   File? _selectedFile;
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
    final industryData = {
      'type': "factory_structure", 
      'location_line_1': _location1,
      'location_line_2': _location2,
      "plan_details": _planDetails,
      "digital_survey": _digitalSurvey,
      "floor_plan": _selectedFile,
    };
    print(industryData);
    _commercialBloc.add(CommercialSubmitEvent(industryData));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
          create: (context) => _commercialBloc,
          child: BlocConsumer<CommercialBloc, CommercialPropState>(
  listenWhen: (previous, current) {
    print('CommercialPage: listenWhen called - Previous: $previous, Current: $current');
    return true; // Add specific conditions if needed
  },
  buildWhen: (previous, current) {
    print('CommercialPage: buildWhen called - Previous: $previous, Current: $current');
    return true; // Add specific conditions if needed
  },
  listener: (context, state) {
    print('CommercialPage: BlocConsumer listener received state: $state');

    if (state is CommercialSubmittedState) {
      print('CommercialPage: Commercial property submission successful, navigating to next page');
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(
      //     content: Text('Commercial property submitted successfully!'),
      //     backgroundColor: Colors.green,
      //   ),
      // );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Confirmation(), // Replace with your next page
          settings: RouteSettings(arguments: auth_token), // Pass token if needed
        ),
      );
    } else if (state is CommercialErrorState) {
      print('CommercialPage: Showing error snackbar');
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
                    const NavigationWidget(navigationItems: ['Execution', 'Commercial', 'Factory Structure']),
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
                    Text('MSR Nagar, Bengaluru, Karnataka- 560054, India.',
                        style: TextStyle(
                            fontSize: Responsive.height(1.5, context),
                            color: Colors.black)),
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
                                border: InputBorder.none
                                
                                ),
                                onSaved: (value) {
                                _location1 = value;
                              },
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
                              },
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
                                onSaved: (value){
                                  _planDetails = value;
                                },
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
                              _digitalSurvey = "True";
                            },
                            child: Center(
                              child: Text('Yes',
                                  style: TextStyle(
                                      fontSize: Responsive.height(2.5, context))),
                            ),
                            style: ButtonStyle(
                              side: MaterialStateProperty.resolveWith<BorderSide>(
                                  (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return const BorderSide(
                                      color: Colors
                                          .purple); // Border color when button is pressed
                                }
                                return const BorderSide(
                                    color: Color.fromRGBO(105, 105, 105,
                                        1)); // Transparent border when button is not pressed
                              }),
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
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
                              _digitalSurvey = "False";
                            },
                            child: Center(
                              child: Text('No',
                                  style: TextStyle(
                                      fontSize: Responsive.height(2.5, context))),
                            ),
                            style: ButtonStyle(
                              side: MaterialStateProperty.resolveWith<BorderSide>(
                                  (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return const BorderSide(
                                      color: Colors
                                          .purple); // Border color when button is pressed
                                }
                                return const BorderSide(
                                    color: Color.fromRGBO(105, 105, 105,
                                        1)); // Transparent border when button is not pressed
                              }),
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
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
                        onPressed: _submitForm,
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
          ),
        ));
  }
}
