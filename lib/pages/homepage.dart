import 'package:flutter/material.dart';
import 'package:kriv/pages/architecture_and_design/architecture_design.dart';
import 'package:kriv/pages/architecture_and_design/interior_design.dart';
import 'package:kriv/pages/execution/commercial.dart';
import 'package:kriv/pages/execution/house.dart';
import 'package:kriv/pages/execution/industrial.dart';
import 'package:kriv/pages/project_management/project.dart';
import 'package:kriv/pages/project_management/services.dart';
import 'package:kriv/pages/real_estate/buy_land.dart';
import 'package:kriv/pages/real_estate/sell_land.dart';
import 'package:kriv/pages/swimming_pool/swimming_pool.dart';
import '../utilities/responsive.dart';
import '../widgets/folders.dart';
import 'package:defer_pointer/defer_pointer.dart';
class HomePage extends StatefulWidget {
  
  const HomePage({Key? key,}) : super(key: key);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  bool repeatTap = false;
  String selectedFolder ='';
  List<Function> executionNavigation = [() => const House(), () => const Industrial(), () => const Commercial()];
  List<Function> productManagementNavigation = [() => const Project(), () => const Services()];
  List<Function> designNavigation = [() => const ArchitectureDesign(), () => const InteriorDesign(), () => const Industrial()];
  List<Function> realEstateNavigation = [() => const BuyLand(), () => const SellLand()];
  List<Function> swimmingPoolNavigation = [() => const SwimmingPool()];
    void updateOffset(folderToAnimate)
   {
      if(selectedFolder==folderToAnimate && repeatTap==false)
      {
        repeatTap=true;
      }
      else {
        repeatTap=  false;
      }
      selectedFolder=folderToAnimate;
      setState(() {
        
      });
     
   }
   Offset decideOffset(title)
   {
    if(title=="Execution")
    {return const Offset(0,-0.33);}
    else if(title=="Product Management")
    {return const Offset(0,-0.20);}
    else if(title=="Design and Architecture")
    {return const Offset(0,-0.35);}
    else if(title=="Real Estate")
    {return const Offset(0,-0.60);}
    else // if title is Swimming Pool
    {return const Offset(0,0);}
    
   }
  @override
  Widget build(BuildContext context) {
    
     Offset offset = const Offset(0,-0.33);
  final animationDuration = const  Duration(milliseconds: 600);
    const Color customPurple = Color(0xFF6C3CA9);
    const Color customGrey = Color(0xFF515151);
    
    var leftSpacing = Responsive.width(5.3, context);
    return Material(
      child: SafeArea(
        child: Scaffold(
          
            body: ClipPath(
              clipper: BottomClipper(),
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                child: Column(
                          children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      leftSpacing,
                      Responsive.height(1.8, context),
                      Responsive.width(5.4, context),
                      0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        child: Image.asset('assets/images/burger_icon.png'),
                        onTap: () {},
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text('Login/Sign up',
                            style: TextStyle(
                                color: customPurple,
                                fontSize: Responsive.height(2, context),
                                fontWeight: FontWeight.w500)),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(
                      Responsive.width(5.4, context),
                      Responsive.height(1.7, context),
                      Responsive.width(5.7, context),
                      0),
                  alignment: Alignment.topLeft,
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: Responsive.width(7.5, context),
                          letterSpacing: 0,
                          fontWeight: FontWeight.w600),
                      children: const [
                        TextSpan(
                            text: 'design, ',
                            style: TextStyle(
                              color: Colors.black,
                            )),
                        TextSpan(
                            text: 'build, ',
                            style: TextStyle(
                              color: customPurple,
                            )),
                        TextSpan(
                            text: 'create.',
                            style: TextStyle(
                              color: Colors.black,
                            )),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(
                      leftSpacing,
                      Responsive.height(1, context),
                      Responsive.width(10, context),
                      0),
                  child: const Text(
                    'All-in-one civil services app that streamlines real estate, design, project management, consultancy and flawless execution',
                    softWrap: true,
                    style:
                        TextStyle(color: customGrey, fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: Responsive.height(6.5, context),
                ),
                DeferredPointerHandler(
                  child: Container(
                      height: Responsive.height(67, context),
                      width: Responsive.width(94, context),
                      child:  Stack(
                        
                        clipBehavior: Clip.none,
                        alignment: Alignment.topCenter,
                        children: [ 
                          Positioned(
                          top: Responsive.height(0, context),
                          child: AnimatedSlide(
                           offset: selectedFolder=='Execution' && repeatTap==false ?decideOffset("Execution") :Offset.zero,
                            duration:  animationDuration,
                            curve: Curves.easeInOut,
                            child: DeferPointer(
                              child: GestureDetector(
                                onTap: ()=> {updateOffset('Execution')},
                                child: Container(
                                  height: Responsive.height(60, context), 
                                  width: Responsive.width(94, context),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(25),
                                    child:   Folders(
                                      title: 'Execution',
                                      titleColor: Colors.black,
                                      color: const Color(0xFFF6F0FF),
                                      numberOfButtons: 3,
                                      buttonColor: const Color.fromARGB(255, 230, 216, 249),
                                      buttonTextColor: Colors.black,
                                      buttonText: ['House', 'Industrial', 'Commercial'],
                                      buttonFunctions: executionNavigation,
                                      
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                                                ),
                        Positioned(
                          top: Responsive.height(9, context),
                          child: Transform.translate(
                            offset: offset,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Container(
                              height: Responsive.height(60, context),
                              width: Responsive.width(94, context),
                              color:  const Color(0xFFF6F0FF),
                                                    ),
                            ),
                          )),
                        Positioned(
                          top: Responsive.height(10, context),
                          child: AnimatedSlide(
                             offset: selectedFolder=='Product Management' && repeatTap==false ?decideOffset("Product Management") :Offset.zero,
                            duration: animationDuration,
                            curve: Curves.easeInOut,
                            child: DeferPointer(
                              child: GestureDetector(
                                onTap: ()=> updateOffset('Product Management') ,
                                child: Container(
                                height: Responsive.height(60, context),
                                width: Responsive.width(94, context),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child:   Folders(
                                  title: 'Project \nManagement',
                                  titleColor: Colors.black,
                                  color: const Color(0xFFE2D2F8),
                                  numberOfButtons: 2,
                                  buttonColor: const Color(0xFFDABEFF),
                                  buttonTextColor: Colors.black,
                                  buttonText: ['Project','Property'],
                                  buttonFunctions: productManagementNavigation,
                                  
                                                    ),
                                ),),
                              ),
                            ),
                          ),
                        ),
                        Positioned(top: Responsive.height(21, context),
                        child: Container(
                          height: Responsive.height(60, context),
                          width: Responsive.width(94, context),
                          color:  const Color(0xFFE2D2F8),
                          child: ClipRRect(borderRadius: BorderRadius.circular(25) ,),
                        )),
                        Positioned(
                          top: Responsive.height(21, context),
                          child: AnimatedSlide(
                            offset: selectedFolder=='Design and Architecture' && repeatTap==false ?decideOffset("Design and Architecture") :Offset.zero,
                            duration: animationDuration,
                            curve: Curves.easeInOut,
                            child: DeferPointer(
                              child: GestureDetector(
                                onTap: ()=> updateOffset('Design and Architecture'),
                                child: Container(
                                height: Responsive.height(60, context),
                                width: Responsive.width(94, context),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child:   Folders(
                                  title: 'Design and\nArchitecture',
                                  titleColor: Colors.white,
                                  color: const Color(0xFFB185EB),
                                  numberOfButtons: 3,
                                  buttonColor: const Color(0xFFA176D9),
                                  buttonTextColor: Colors.white,
                                  buttonText: ['House','Commericial','Industrial'],
                                  buttonFunctions: designNavigation,
                                  
                                                    ),
                                ),),
                              ),
                            ),
                          ),
                        ),
                         Positioned(top: Responsive.height(31, context),
                        child: Container(
                          height: Responsive.height(60, context),
                          width: Responsive.width(94, context),
                          color:  const Color(0xFFB185EB),
                          child: ClipRRect(borderRadius: BorderRadius.circular(25) ,),
                        )),
                        Positioned(
                          top: Responsive.height(32, context),
                          child: AnimatedSlide(
                            offset: selectedFolder=='Real Estate' && repeatTap==false ?decideOffset("Real Estate") :Offset.zero,
                            duration: animationDuration,
                            curve: Curves.easeInOut,
                            child: DeferPointer(
                              child: GestureDetector(
                                onTap: ()=> updateOffset('Real Estate'),
                                child: Container(
                                height: Responsive.height(60, context),
                                width: Responsive.width(94, context),
                                child:   Folders(
                                title: 'Real Estate',
                                titleColor: Colors.white,
                                color: const Color(0xFF6B4397),
                                description: 'this is a long description that will be added later this is just to see if text wrapping is working and how this will affect spacing',
                                numberOfButtons: 5,
                                buttonColor: const Color(0xFF7A4DAC),
                                buttonTextColor: Colors.white,
                                buttonText: ['Buy','Sell','Study','Lias','Paperworks'],
                                buttonFunctions: realEstateNavigation,
                                
                                ),
                                ),
                                
                                ),
                            )
                              ),
                            ),
                          
                        
                        Positioned(top: Responsive.height(42, context),
                        child: Container(
                          height: Responsive.height(60, context),
                          width: Responsive.width(94, context),
                          color:  const Color(0xFF6B4397),
                        )),
                        Positioned(
                          top: Responsive.height(42, context),
                          child: AnimatedSlide(
                            offset: selectedFolder=='Swimming Pool' && repeatTap==false ?decideOffset("Swimming Pool") :Offset.zero,
                            duration: animationDuration,
                            curve: Curves.easeInOut,
                            child: DeferPointer(
                              child: GestureDetector(
                                onTap: (){Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SwimmingPool()),
                              );},
                                child: Container(
                                height: Responsive.height(60, context),
                                width: Responsive.width(94, context),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child:  const Folders(
                                  title: 'Swimming Pool',
                                  titleColor: Colors.white,
                                  color: Color(0xFF34185A),
                                  description: 'this is a long description that will be added later this is just to see if text wrapping is working and how this will affect spacing',
                                  numberOfButtons: 0,
                                  buttonColor: Color(0xFF5E2A8A),
                                  buttonTextColor: Colors.white,
                                  buttonText: [],
                                  buttonFunctions: [],
                                  
                                                    ),
                                ),),
                              ),
                            ),
                          ),
                        ),
                                ])),
                ),
                          ],
                        ),
              ),
            )),
      ),
    );
  }
}
class BottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(size.width, size.height*0.86);
    path.conicTo(size.width*0.99, size.height*0.97, size.width*0.89, size.height*0.97,1);
    path.lineTo(size.width*0.11, size.height*0.97);
    path.conicTo(size.width*0.01, size.height*0.97, 0, size.height*0.86,1);  
    path.lineTo(0, 0);
    path.lineTo(size.width, 0);
    
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

