import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../utilities/responsive.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    const Color customPurple = Color(0xFF6C3CA9);
    const Color customGrey = Color(0xFF515151);
    return   Material(
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(21,21,21,0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(child: Image.asset('assets/images/burger_icon.png'), onTap: (){},),
                    Text('Login/Sign up', style: TextStyle(color:customPurple, fontSize:  Responsive.height(2.1, context), fontWeight: FontWeight.w500),)
                  ],
      
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(23, 15, 21, 0),
                alignment: Alignment.topLeft,
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(fontFamily: 'Poppins',fontSize: Responsive.width(7.5, context),letterSpacing: 0, fontWeight: FontWeight.w600),
                    children:  const [
                      TextSpan(text: 'design, ',style: TextStyle(color:Colors.black, )),
                      TextSpan(text: 'build, ', style: TextStyle(color:customPurple, )),
                      TextSpan(text: 'create.',style: TextStyle(color:Colors.black, )),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(23, 5, 50, 0),
                child: Text('All-in-one civil services app that streamlines real estate, design, progect management, consultancy and flawless execution', softWrap: true, style: TextStyle(color: customGrey, fontWeight: FontWeight.w400),),
                ),
                SizedBox(
                  height: Responsive.height(10, context),
                ),
                 const Stack(
                  alignment: Alignment.topCenter,
                  children:[
                   Image(image: AssetImage('assets/images/homepage_folders/Execution.png'),),
                   Positioned(
                    top:80 ,
                    child: Image(image: AssetImage('assets/images/homepage_folders/ProjectManagement.png'),))
                   ])
                
              
            ],
          )
        ),
      ),
    );
  }
}
