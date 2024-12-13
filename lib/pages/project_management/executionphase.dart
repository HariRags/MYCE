import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kriv/pages/homepage.dart';
import 'package:kriv/pages/project_management/contactus_execution.dart';
import 'package:kriv/utilities/execution_bloc.dart';
import 'package:kriv/utilities/responsive.dart';
import 'package:kriv/utilities/swimming_bloc.dart';
import 'package:kriv/widgets/myce_backbutton.dart';
import 'package:kriv/widgets/navigation.dart';

class ExecutionPhase extends StatefulWidget {
  final String? authToken;
  const ExecutionPhase({Key? key,required this.authToken}) : super(key: key);

  @override
  State<ExecutionPhase> createState() => _ExecutionPhaseState();
}

class _ExecutionPhaseState extends State<ExecutionPhase> {
  String auth_token="";
  late ExecutionBloc _executionBloc;
  @override
  void initState() {
    super.initState();
    // Access houseBloc from the context here
    final executionBloc = BlocProvider.of<ExecutionBloc>(context);
    auth_token = executionBloc.authToken;
    _executionBloc = ExecutionBloc(auth_token);
  }

  final _equipmentFormKey = GlobalKey<FormState>();

  String? _equipmentList;

  void _submitForm() {
    if (_equipmentFormKey.currentState!.validate()) {
      _equipmentFormKey.currentState!.save();
    }

      print("submitted");
      final houseData = {
        'report':_equipmentList,
        'auth_token' :auth_token
      };
      print(houseData);
      Navigator.push(
          context,
          MaterialPageRoute(
            // push to a contact us
            builder: (context) => ContactUs(authToken: auth_token),
            settings: RouteSettings(arguments: houseData) // Replace with your next page
          ),
      );

      // FIX ME : When backend is done then uncomment the below code and remove th3e upper navigation
      // _executionBloc.add(ExecutionSubmitEvent(houseData));
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
          create: (context) => _executionBloc,
          child: BlocConsumer<ExecutionBloc,ExecutionState>(
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

      if (state is ExecutionSubmittedState) {
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
            // push to a contact us
            builder: (context) => ContactUs(authToken: auth_token),
            settings: RouteSettings(arguments: auth_token) // Replace with your next page
          ),
        );
      } else if (state is ExecutionErrorState) {
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
                    const NavigationWidget(navigationItems: ['Project Management','Project Management Phase', 'Execution Phase']),
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
                      'Follow up with contractors and architects with detailed report',
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
                        height: Responsive.height(18, context),
                        alignment: Alignment.topLeft,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: const Color.fromRGBO(149, 149, 149, 1)),
                            borderRadius: BorderRadius.circular(6)),
                        child: Form(
                          key: _equipmentFormKey,
                          child: TextFormField(
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    left: Responsive.width(1, context),
                                    bottom: Responsive.height(1.2, context)),
                                border: InputBorder.none),
                                onChanged: (value) {
                                  _equipmentList = value;
                                } ,
                          ),
                        )),
                   
                    SizedBox(
                      height: Responsive.height(2.2, context),
                    ),
                    
                    Container(
                      width: Responsive.width(95, context),
                      height: Responsive.height(6.5, context),
                      child: FilledButton(
                        // FIX ME : write submit form when backend is done
                        onPressed: _submitForm,
                        child: Text(
                          'Contact Us',
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
