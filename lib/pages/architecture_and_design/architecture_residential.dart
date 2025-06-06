import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kriv/pages/home.dart';
import 'package:kriv/pages/homepage.dart';
import 'package:kriv/utilities/architecture_design_bloc.dart';
import 'package:kriv/utilities/global.dart';
import 'package:kriv/utilities/maps.dart';
import 'package:kriv/utilities/responsive.dart';
import 'package:kriv/widgets/myce_backbutton.dart';
import 'package:kriv/widgets/navigation.dart';
import 'package:kriv/pages/confirmation.dart';

class ArchitectureResidential extends StatefulWidget {
  const ArchitectureResidential({Key? key}) : super(key: key);

  @override
  State<ArchitectureResidential> createState() => _ArchitectureResidentialState();
}

class _ArchitectureResidentialState extends State<ArchitectureResidential> {
  String auth_token="";
  late ArchitectureBloc _architectureBloc;
  @override
  void initState() {
    super.initState();
    // Access houseBloc from the context here
    final architectureBloc = BlocProvider.of<ArchitectureBloc>(context);
    auth_token = architectureBloc.authToken;
    _architectureBloc = ArchitectureBloc(auth_token);
  }
  final _formKey = GlobalKey<FormState>();
  final _locationFormKey = GlobalKey<FormState>();
  final _landSizeFormKey = GlobalKey<FormState>();
  final _requirementsFormKey = GlobalKey<FormState>();
bool _isYesPressed = false;
  bool _isNoPressed = false;
  String? _location1;
  String? _location2;
  String? _landSize;
  String _selectedUnit = 'sq. ft.'; // Define this in your state
  final List<String> _units = ['sq. ft.', 'gunta', 'acre'];
  String? _digitalSurvey;
  String? _requirements;
  String? _location;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }
    if (_locationFormKey.currentState!.validate()) {
      _locationFormKey.currentState!.save();
    }
    if (_landSizeFormKey.currentState!.validate()) {
      _landSizeFormKey.currentState!.save();
    }
    if (_requirementsFormKey.currentState!.validate()) {
      _requirementsFormKey.currentState!.save();
    }
      
      final houseData = {
        'requirement_type': "Residential Apartment", 
        'location_line_1': _location1,
        'location_line_2' : _location2,
        "land_size": _landSize,
        "land_size_unit": _selectedUnit,
        "digital_survey": _digitalSurvey,
        "floor_plan": _requirements,
        "location":_location
      };
         String? errorMessage;
    for (var entry in houseData.entries) {
      if (entry.value == null || entry.value.toString().trim().isEmpty) {
        errorMessage =
            'Enter all the details';
        break;
      }
    }
    final landSizeValue = _landSize != null ? int.tryParse(_landSize!) : null;

    if (landSizeValue == null || landSizeValue <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid positive number for land size'),
          backgroundColor: Colors.red,
        ),
      );
      return;
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
      _architectureBloc.add(ArchitectureSubmitEvent(houseData));
    
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
          create: (context) => _architectureBloc,
          child: BlocConsumer<ArchitectureBloc,ArchitectureState>(
             listenWhen: (previous, current) {
      
      return true; // You can add specific conditions here if needed
    },
    buildWhen: (previous, current) {
      
      return true; // You can add specific conditions here if needed
    },
    listener: (context, state) {
      

      if (state is ArchitectureSubmittedState) {
        
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
      } else if (state is ArchitectureErrorState) {
        if(state.isSessionExpired){
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
              settings: RouteSettings(arguments: globals.accessToken)
            ),
            (route) => false, // This will remove all previous routes
          );
        }else{
          ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.message),
            backgroundColor: Colors.red,
          ),
        );
        }
      }
    },
            builder: (context, state){
              return SafeArea(
                  child: Column(children: [
                    const MYCEBackButton(),
                    const NavigationWidget(navigationItems: ['Architecture & Design', 'Architecture Design', 'Residential Apartment']),
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
                            
              
                      },
                      child: Container(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  size: Responsive.height(3, context),
                                  color: const Color.fromRGBO(107, 67, 151, 1),
                                ),
                                Text(
                                    (_location == null)
                                        ? 'Select the location'
                                        : _location!,
                                    style: TextStyle(
                                        fontSize:
                                            Responsive.height(2, context),
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
                                onChanged: (value) {
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
                                onChanged: (value) {
                                  _location2 = value;
                                },
                          ),
                        )),
                    SizedBox(
                      height: Responsive.height(2.2, context),
                    ),
                    Text(
                      'Land Size',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: Responsive.height(2.5, context)),
                    ),
                    SizedBox(
                      height: Responsive.height(1, context),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Container(
                              padding: EdgeInsets.only(left: Responsive.width(2, context)),
                              height: Responsive.height(5, context),
                              width: Responsive.width(66, context),
                              alignment: Alignment.topLeft,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: const Color.fromRGBO(149, 149, 149, 1)),
                                  borderRadius: BorderRadius.circular(6)),
                              child: Form(
                                key: _landSizeFormKey,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                          left: Responsive.width(1, context),
                                          bottom: Responsive.height(1.2, context)),
                                      border: InputBorder.none),
                                      onChanged: (value) {
                                        _landSize = value;
                                      },
                                ),
                              )),
                              SizedBox(width: Responsive.width(2, context)),

    // Unit dropdown
                              Container(
                                height: Responsive.height(5, context),
                                width: Responsive.width(25, context),
                                padding: EdgeInsets.symmetric(horizontal: Responsive.width(3, context)),
                                decoration: BoxDecoration(
                                  border: Border.all(color: const Color.fromRGBO(149, 149, 149, 1)),
                                  borderRadius: BorderRadius.circular(6),
                                  // color: Colors.white,
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: _selectedUnit,
                                    isExpanded: true,
                                    items: _units.map((String unit) {
                                      return DropdownMenuItem<String>(
                                        value: unit,
                                        child: Text(unit),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _selectedUnit = newValue!;
                                      });
                                    },
                                  ),
                                ),
                              ),
                        ],
                      ),
                    ),
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
                      'Requirements',
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
                          key: _requirementsFormKey,
                          child: TextFormField(
                            decoration: InputDecoration(
                                // hintText: '.pdf/.jpg/.png',
                                hintStyle: TextStyle(
                                    color: const Color.fromRGBO(0, 0, 0, 1),
                                    fontSize: Responsive.height(1.6, context),
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.italic),
                                contentPadding: EdgeInsets.only(
                                    left: Responsive.width(1, context),
                                    bottom: Responsive.height(1.2, context)),
                                border: InputBorder.none),
                                onChanged: (value) {
                                  _requirements = value;
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
