import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kriv/pages/confirmation.dart';
import 'package:kriv/pages/home.dart';
import 'package:kriv/pages/homepage.dart';
import 'package:kriv/utilities/global.dart';
import 'package:kriv/utilities/maps.dart';
import 'package:kriv/utilities/responsive.dart';
import 'package:kriv/utilities/sell_bloc.dart';
import 'package:kriv/widgets/imagepicker.dart';
import 'package:kriv/widgets/myce_backbutton.dart';
import 'package:kriv/widgets/navigation.dart';
import 'dart:io';
class SellCommercial extends StatefulWidget {
  
  const SellCommercial({Key? key}) : super(key: key);

  @override
  State<SellCommercial> createState() => _SellCommercialState();
}

class _SellCommercialState extends State<SellCommercial> {
  String auth_token="";
  late SellBloc _sellBloc;
  @override
  void initState() {
    super.initState();
    // Access houseBloc from the context here
    final sellBloc = BlocProvider.of<SellBloc>(context);
    auth_token = sellBloc.authToken;
    _sellBloc = SellBloc(auth_token);
  }
  final _formKey = GlobalKey<FormState>();
  final _locationFormKey = GlobalKey<FormState>();
  final _sizeFormKey = GlobalKey<FormState>();
  final _ownerFormKey = GlobalKey<FormState>();
  final _expectedFormKey = GlobalKey<FormState>();

  String? _location1;
  String? _location2;
  String? _size;
  String? _ownerDetails;
  File? _propertyDocs;
  String? _propertyDocsName;
  String? _expectedPrice;
  String? _location;

  Future<void> selectFile() async {
    // Use the utility function to pick a file
    final result = await pickFile();

    if (result != null) {
      setState(() {
        _propertyDocs = result['file'];
        _propertyDocsName = result['fileName'];
      });
    } else {
      setState(() {
        _propertyDocs = null;
        _propertyDocsName = null;
        
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
    if (_sizeFormKey.currentState!.validate()) {
      _sizeFormKey.currentState!.save();
    }
    if (_ownerFormKey.currentState!.validate()) {
      _ownerFormKey.currentState!.save();
    }
    if (_expectedFormKey.currentState!.validate()) {
      _expectedFormKey.currentState!.save();
    }
      
      final houseData = {
        // FIX ME : Check api once backend changes property_type 
        'property_type': "Commercial", 
        'location_line_1': _location1,
        'location_line_2' : _location2,
        "land_size": _size,
        "owner_details": _ownerDetails,
        "property_documents": _propertyDocs,
        "expected_price":_expectedPrice,
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
    final budget = _expectedPrice != null ? int.tryParse(_expectedPrice!) : null;

    if (budget == null || budget <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid positive number for expected price'),
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
      _sellBloc.add(SellSubmitEvent(houseData));
    
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
          create: (context) => _sellBloc,
          child: BlocConsumer<SellBloc,SellState>(
 listenWhen: (previous, current) {
      
      return true; // You can add specific conditions here if needed
    },
    buildWhen: (previous, current) {
      
      return true; // You can add specific conditions here if needed
    },
    listener: (context, state) {
      

      if (state is SellSubmittedState) {
        
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
      } else if (state is SellErrorState) {
        
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
                    const NavigationWidget(navigationItems: ['Real Estate', 'Sell', 'Commercial']),
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
                                onChanged: (value){
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
                        padding: EdgeInsets.only(left: Responsive.width(2, context)),
                        height: Responsive.height(5, context),
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
                    SizedBox(
                      height: Responsive.height(2.2, context),
                    ),
                    Text(
                      'Owner Details',
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
                          key: _ownerFormKey,
                          child: TextFormField(
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    left: Responsive.width(1, context),
                                    bottom: Responsive.height(1.2, context)),
                                border: InputBorder.none),
                                onChanged: (value){
                                  _ownerDetails = value;
                                },
                          ),
                        )),
                    // Row(
                    //   children: [
                    //     Container(
                    //       height: Responsive.height(5.5, context),
                    //       width: Responsive.width(45, context),
                    //       child: OutlinedButton(
                    //         onPressed: () {},
                    //         child: Center(
                    //           child: Text('Yes',
                    //               style: TextStyle(
                    //                   fontSize: Responsive.height(2.5, context))),
                    //         ),
                    //         style: ButtonStyle(
                    //           side: MaterialStateProperty.resolveWith<BorderSide>(
                    //               (Set<MaterialState> states) {
                    //             if (states.contains(MaterialState.pressed)) {
                    //               return const BorderSide(
                    //                   color: Colors
                    //                       .purple); // Border color when button is pressed
                    //             }
                    //             return const BorderSide(
                    //                 color: Color.fromRGBO(105, 105, 105,
                    //                     1)); // Transparent border when button is not pressed
                    //           }),
                    //           shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    //               borderRadius: BorderRadius.circular(15))),
                    //         ),
                    //       ),
                    //     ),
                    //     SizedBox(
                    //       width: Responsive.width(2, context),
                    //     ),
                    //     Container(
                    //       height: Responsive.height(5.5, context),
                    //       width: Responsive.width(45, context),
                    //       child: OutlinedButton(
                    //         onPressed: () {},
                    //         child: Center(
                    //           child: Text('No',
                    //               style: TextStyle(
                    //                   fontSize: Responsive.height(2.5, context))),
                    //         ),
                    //         style: ButtonStyle(
                    //           side: MaterialStateProperty.resolveWith<BorderSide>(
                    //               (Set<MaterialState> states) {
                    //             if (states.contains(MaterialState.pressed)) {
                    //               return const BorderSide(
                    //                   color: Colors
                    //                       .purple); // Border color when button is pressed
                    //             }
                    //             return const BorderSide(
                    //                 color: Color.fromRGBO(105, 105, 105,
                    //                     1)); // Transparent border when button is not pressed
                    //           }),
                    //           shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    //               borderRadius: BorderRadius.circular(15))),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    SizedBox(
                      height: Responsive.height(2.5, context),
                    ),
                    Text(
                      'Property Documents',
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
                                child: _propertyDocs != null
                                        ? Row(
                                            children: [
                                              if (_propertyDocs!.path
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
                                  'Sketch Copy (.pdf/.jpg/.png)',
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
                    Text(
                      'Expected Price',
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
                          key: _expectedFormKey,
                          child: TextFormField(
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    left: Responsive.width(1, context),
                                    bottom: Responsive.height(1.2, context)),
                                border: InputBorder.none),
                                onChanged: (value){
                                  _expectedPrice = value;
                                },
                          ),
                        )),
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
  },
          ),
        ));
  }
}
