import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kriv/pages/confirmation.dart';
import 'package:kriv/pages/home.dart';
import 'package:kriv/pages/homepage.dart';
import 'package:kriv/utilities/buy_bloc.dart';
import 'package:kriv/utilities/global.dart';
import 'package:kriv/utilities/maps.dart';
import 'package:kriv/utilities/responsive.dart';
import 'package:kriv/widgets/myce_backbutton.dart';
import 'package:kriv/widgets/navigation.dart';

class BuyCommercial extends StatefulWidget {
  final String? authToken;
  const BuyCommercial({Key? key, required this.authToken}) : super(key: key);

  @override
  State<BuyCommercial> createState() => _BuyCommercialState();
}

class _BuyCommercialState extends State<BuyCommercial> {
  String auth_token="";
  late BuyBloc _buyBloc;
  @override
  void initState() {
    super.initState();
    // Access houseBloc from the context here
    final buyBloc = BlocProvider.of<BuyBloc>(context);
    auth_token = buyBloc.authToken;
    _buyBloc = BuyBloc(auth_token);
  }
  final _formKey = GlobalKey<FormState>();
  final _locationFormKey = GlobalKey<FormState>();
  final _sizeFormKey = GlobalKey<FormState>();
  final _budgetFormKey = GlobalKey<FormState>();

  String? _location1;
  String? _location2;
  String? _size;
  String? _budget = '50';
  String _selectedUnit = 'sq. ft.'; // Define this in your state
  final List<String> _units = ['sq. ft.', 'gunta', 'acre'];
  String? _location;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }
    if (_locationFormKey.currentState!.validate()) {
      _locationFormKey.currentState!.save();
    }
    if (_sizeFormKey.currentState!.validate()) {
      _sizeFormKey.currentState!.save();
    }
    if (_budgetFormKey.currentState!.validate()) {
      _budgetFormKey.currentState!.save();
    }
 
      
      final houseData = {
        'property_type': "Commercial", 
        'location_line_1': _location1,
        'location_line_2' : _location2,
        "land_size": _size,
        "land_size_unit": _selectedUnit,
        "budget": _budget,
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
final landSizeValue = _size != null ? int.tryParse(_size!) : null;

    if (landSizeValue == null || landSizeValue <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid positive number for size'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    final budget = _budget != null ? int.tryParse(_budget!) : null;

    if (budget == null || budget <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid positive number for budget'),
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
      _buyBloc.add(BuySubmitEvent(houseData));
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
          create: (context) => _buyBloc,
          child: BlocConsumer<BuyBloc,BuyState>(
 listenWhen: (previous, current) {
      
      return true; // You can add specific conditions here if needed
    },
    buildWhen: (previous, current) {
      
      return true; // You can add specific conditions here if needed
    },
    listener: (context, state) {
      

      if (state is BuySubmittedState) {
        
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
            builder: (context) => const Confirmation(),
            settings: RouteSettings(arguments: auth_token) // Replace with your next page
          ),
        );
      } else if (state is BuyErrorState) {
        
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
            builder: (context,state){
              return SafeArea(
                  child: Column(children: [
                    const MYCEBackButton(),
                    const NavigationWidget(navigationItems: ['Real Estate', 'Buy', 'Commercial']),
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
                      'Size',
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
                                key: _sizeFormKey,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                          left: Responsive.width(1, context),
                                          bottom: Responsive.height(1.2, context)),
                                      border: InputBorder.none),
                                      onChanged: (value) {
                                        _size = value;
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
                      'Budget',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: Responsive.height(2.5, context)),
                    ),
                    SizedBox(
                      height: Responsive.height(1, context),
                    ),
                    Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('30 L', style: TextStyle(fontSize: 14)),
                              Text(
                                '${_budget} L',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.purple,
                                ),
                              ),
                              Text('1 cr', style: TextStyle(fontSize: 14)),
                            ],
                          ),
                        ),

                        // Slider
                        Slider(
                          value: double.tryParse(_budget!) ?? 50.0, // Start from 50
                          min: 30,
                          max: 100,
                          divisions: 70,
                          activeColor: Colors.purple,
                          inactiveColor: Colors.grey[400],
                          onChanged: (value) {
                            setState(() {
                              _budget = value.round().toString();
                            });
                          },
                        ),
                        Center(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'Rs. $_budget L',
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                    SizedBox(
                      height: Responsive.height(2.2, context),
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
}
          ),
        ));
  }
}
