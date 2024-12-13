import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kriv/pages/homepage.dart';
import 'package:kriv/utilities/responsive.dart';
import 'package:kriv/utilities/services_bloc.dart';
import 'package:kriv/widgets/myce_backbutton.dart';
import 'package:kriv/widgets/navigation.dart';

class Services extends StatefulWidget {
  final String? authToken;
  const Services({Key? key,required this.authToken}) : super(key: key);

  @override
  State<Services> createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  String auth_token="";
  late ServicesBloc _servicesBloc;
  @override
  void initState() {
    super.initState();
    // Access houseBloc from the context here
    final servicesBloc = BlocProvider.of<ServicesBloc>(context);
    auth_token = servicesBloc.authToken;
    _servicesBloc = ServicesBloc(auth_token);
  }
  final _securityKey = GlobalKey<FormState>();
  final _houseKeepingKey = GlobalKey<FormState>();
  final _propertyTaxKey = GlobalKey<FormState>();
  final _repairKey= GlobalKey<FormState>();

  String? _security;
  String? _houseKeeping;
  String? _propertyTax;
  String? _repair;


  void _submitForm() {
    if (_securityKey.currentState!.validate()) {
      _securityKey.currentState!.save();
    }
    if (_houseKeepingKey.currentState!.validate()) {
      _houseKeepingKey.currentState!.save();
    }
    if (_propertyTaxKey.currentState!.validate()) {
      _propertyTaxKey.currentState!.save();
    }
    if (_repairKey.currentState!.validate()) {
      _repairKey.currentState!.save();
    }
      print("submitted");
      final servicesData = {
        'securities': _security,
        'house_keeping' : _houseKeeping,
        "property_tax": _propertyTax,
        "repair": _repair
      };
      _servicesBloc.add(ServicesSubmitEvent(servicesData));
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
          create: (context) => _servicesBloc,
          child: BlocConsumer<ServicesBloc,ServicesState>(
           listenWhen: (previous, current) {
            print('ServicesPage: listenWhen called - Previous: $previous, Current: $current');
            return true;
          },
          buildWhen: (previous, current) {
            print('ServicesPage: buildWhen called - Previous: $previous, Current: $current');
            return true;
          },
          listener: (context, state) {
            print('ServicesPage: BlocConsumer listener received state: $state');
            if (state is ServicesSubmittedState) {
              print('ServicesPage: Services submission successful, navigating to next page');
              // ScaffoldMessenger.of(context).showSnackBar(
              //   const SnackBar(
              //     content: Text('Services submitted successfully!'),
              //     backgroundColor: Colors.green,
              //   ),
              // );
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                  settings: RouteSettings(arguments: _servicesBloc.authToken),
                ),
              );
            } else if (state is ServicesErrorState) {
              print('ServicesPage: Showing error snackbar');
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
                    const NavigationWidget(navigationItems: ['Project Management', 'Project Management Services']),
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
                      'Security',
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
                          child: TextFormField(
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    left: Responsive.width(1, context),
                                    bottom: Responsive.height(1.2, context)),
                                border: InputBorder.none),
                                onSaved: (value) {
                                        _security = value;
                                      }
                          ),
                        )),
                    SizedBox(
                      height: Responsive.height(2.2, context),
                    ),
                    Text(
                      'House keeping',
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
                          child: TextFormField(
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    left: Responsive.width(1, context),
                                    bottom: Responsive.height(1.2, context)),
                                border: InputBorder.none),
                                onSaved: (value) {
                                        _houseKeeping = value;
                                      }
                          ),
                        )),
                    SizedBox(
                      height: Responsive.height(2.2, context),
                    ),
                    
                    Text(
                      'Property tax',
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
                          child: TextFormField(
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    left: Responsive.width(1, context),
                                    bottom: Responsive.height(1.2, context)),
                                border: InputBorder.none),
                                onSaved: (value) {
                                        _propertyTax = value;
                                      }
                          ),
                        )),
                    SizedBox(
                      height: Responsive.height(2.2, context),
                    ),
                    Text(
                      'Electrical and plumbing repairs',
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
                          child: TextFormField(
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    left: Responsive.width(1, context),
                                    bottom: Responsive.height(1.2, context)),
                                border: InputBorder.none),
                                onSaved: (value) {
                                        _repair = value;
                                      }
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
