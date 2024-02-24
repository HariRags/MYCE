import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    
            var _height=Responsive.height(10, context);
    var  leftSpacing= Responsive.width(5.3, context);
    return   Material(
      child: SafeArea(
        child: Scaffold(
           floatingActionButton: FloatingActionButton(
          // When the user taps the button
          onPressed: () {
            // Use setState to rebuild the widget with new values.
            setState(() {
              // Create a random number generator.
             _height=_height*2.5;
            });
          },
          child: const Icon(Icons.play_arrow),
        ),
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
                  child: ClipPath(
                        clipper: CurvyCutoutClipper(),
                        child: Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),color: Colors.purple.shade50) ,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: Responsive.height(4.3, context),),
                              Container(
                                padding: EdgeInsets.only(left: Responsive.width(8, context)) ,
                                child: Text(
                                  'Execution',
                                  style: TextStyle(color: Colors.black, fontSize: Responsive.height(2.7, context), fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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
class CurvyCutoutClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0.0, 0.0);
    path.lineTo(size.width*0.50, 0.0);
    path.cubicTo(size.width*0.61, size.height*0, size.width*0.62, size.height*0.08, size.width*0.73, size.height*0.08); 
    path.lineTo(size.width*0.93, size.height*0.08);
    path.quadraticBezierTo(size.width, size.height*0.081, size.width, size.height*0.13);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.lineTo(0.0, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
