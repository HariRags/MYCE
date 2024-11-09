import 'package:flutter/material.dart';
import 'package:kriv/pages/homepage.dart';
import 'package:kriv/utilities/responsive.dart';
import 'package:kriv/widgets/myce_backbutton.dart';
import 'package:kriv/widgets/navigation.dart';
import 'package:kriv/utilities/industry_post.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class IndustrialRetail extends StatefulWidget {
  const IndustrialRetail({Key? key}) : super(key: key);

  @override
  State<IndustrialRetail> createState() => _IndustrialRetailState();
}

class _IndustrialRetailState extends State<IndustrialRetail> {
  String auth_token = "";
  late IndustryBloc _industryBloc;

  @override
  void initState() {
    super.initState();
    // Access industryBloc from the context here
    final industryBloc = BlocProvider.of<IndustryBloc>(context);
    auth_token = industryBloc.authToken;
    _industryBloc = IndustryBloc(auth_token);
  }

// Provide your auth token here
  final _formKey = GlobalKey<FormState>();
  final _locationFormKey = GlobalKey<FormState>();
  final _planDetailsFormKey = GlobalKey<FormState>();
  final _floorPlanFormKey = GlobalKey<FormState>();

  String? _location1;
  String? _location2;
  String? _planDetails;
  String? _digitalSurvey;
  String? _floorPlan;

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
    if (_floorPlanFormKey.currentState!.validate()) {
      _floorPlanFormKey.currentState!.save();
    }
    print("submitted");
    final industryData = {
      'type': "retail space", // Changed 'villa' to something industry-specific
      'location_line_1': _location1,
      'location_line_2': _location2,
      "plan_details": _planDetails,
      "digital_survey": _digitalSurvey,
      "floor_plan": _floorPlan,
    };
    _industryBloc.add(IndustrySubmitEvent(industryData));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
          create: (context) => _industryBloc,
          child: BlocConsumer<IndustryBloc,IndustryState>(
listenWhen: (previous, current) {
      print('IndustryPage: listenWhen called - Previous: $previous, Current: $current');
      return true; // You can add specific conditions here if needed
    },
    buildWhen: (previous, current) {
      print('IndustryPage: buildWhen called - Previous: $previous, Current: $current');
      return true; // You can add specific conditions here if needed
    },
    listener: (context, state) {
      print('IndustryPage: BlocConsumer listener received state: $state');

      if (state is IndustrySubmittedState) {
        print('IndustryPage: House submission successful, navigating to next page');
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Industry submitted successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        // Navigate to next page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(), // Replace with your next page
            settings: RouteSettings(arguments: auth_token)
          ),
        );
      } else if (state is IndustryErrorState) {
        print('IndustryPage: Showing error snackbar');
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
                    const NavigationWidget(navigationItems: ['Execution', 'Industrial', 'Retail Space']),
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
                    Container(
                        padding: EdgeInsets.only(left: Responsive.width(2, context)),
                        height: Responsive.height(5, context),
                        alignment: Alignment.topLeft,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: const Color.fromRGBO(149, 149, 149, 1)),
                            borderRadius: BorderRadius.circular(6)),
                        child: Form(
                          key: _floorPlanFormKey,
                          child: TextFormField(
                            decoration: InputDecoration(
                                hintText: '.pdf/.jpg/.png',
                                hintStyle: TextStyle(
                                    color: const Color.fromRGBO(0, 0, 0, 1),
                                    fontSize: Responsive.height(1.6, context),
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.italic),
                                contentPadding: EdgeInsets.only(
                                    left: Responsive.width(1, context),
                                    bottom: Responsive.height(1.2, context)),
                                border: InputBorder.none),
                              //   onSaved: (value) {
                              //   _floorPlan = value;
                              // }
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
