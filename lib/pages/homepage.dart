import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utilities/responsive.dart';
import '../widgets/folders.dart';

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
    var  leftSpacing= Responsive.width(5.3, context);
    return   Material(
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Padding(
                padding:  EdgeInsets.fromLTRB(leftSpacing,Responsive.height(1.8, context),Responsive.width(5.4, context),0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(child: Image.asset('assets/images/burger_icon.png'), onTap: (){},),
                    TextButton(onPressed: (){},child: Text('Login/Sign up', style: TextStyle(color:customPurple, fontSize:  Responsive.height(2, context), fontWeight: FontWeight.w500)),)
                  ],
      
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(Responsive.width(5.4, context), Responsive.height(1.7, context), Responsive.width(5.7, context), 0),
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
                padding: EdgeInsets.fromLTRB(leftSpacing, Responsive.height(1, context), Responsive.width(10, context), 0),
                child: const Text('All-in-one civil services app that streamlines real estate, design, project management, consultancy and flawless execution', softWrap: true, style: TextStyle(color: customGrey, fontWeight: FontWeight.w500),),
                ),
                SizedBox(
                  height: Responsive.height(9.3, context),
                ),
                Container(
                  height: Responsive.height(60, context),
                  width: Responsive.width(90, context),
                  child: Folders()
                )
                //    Expanded(
                //    child: Stack(
                //     alignment: Alignment.topCenter,
                //     children:[
                //      Image(image: AssetImage('assets/images/homepage_folders/Execution.png'),),
                //      Positioned(
                //       top:Responsive.height(11, context) ,
                //       child: const Image(image: AssetImage('assets/images/homepage_folders/ProjectManagement.png'),)),
                //       Positioned(
                //       top:Responsive.height(22, context) ,
                //       child: const Image(image: AssetImage('assets/images/homepage_folders/DesignAndArchitecture.png'),)),
                //       Positioned(
                //       top:Responsive.height(33, context) ,
                //       child: const Image(image: AssetImage('assets/images/homepage_folders/RealEstate.png'),)),
                //       Positioned(
                //       top:Responsive.height(44, context) ,
                //       child: const Image(image: AssetImage('assets/images/homepage_folders/SwimmingPool.png'),))

                //      ]),
                //  )
            ],
          )
        ),
      ),
    );
  }
}

