import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import '../utilities/responsive.dart';
import '../widgets/folders.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Offset offset = Offset.zero;
  @override
  Widget build(BuildContext context) {
    const Color customPurple = Color(0xFF6C3CA9);
    const Color customGrey = Color(0xFF515151);
    
    var leftSpacing = Responsive.width(5.3, context);
    return Material(
      child: SafeArea(
        child: Scaffold(
          floatingActionButton: TextButton(
            child: Text('Get Started'),
            onPressed: () {
              setState(() {
                if(offset == Offset(0,0))
                offset = Offset(0,-1);
                else
                offset = Offset(0,0);
              });
            },
          ),
            body: Column(
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
            Container(
                height: Responsive.height(67, context),
                width: Responsive.width(94, context),
                child:  Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.topCenter,
                  children: [ 
                    Positioned(
                    top: Responsive.height(0, context),
                    child: Container(
                      height: Responsive.height(60, context), 
                      width: Responsive.width(94, context),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: const Folders(
                          title: 'Execution',
                          titleColor: Colors.black,
                          color: Color(0xFFF6F0FF),
                          numberOfButtons: 3,
                          buttonColor: Color.fromARGB(255, 230, 216, 249),
                          buttonTextColor: Colors.black,
                          buttonText: ['Commercial', 'Residential', 'Industrial'],
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
                       offset: offset,
                      duration: const Duration(milliseconds: 5000),
                      curve: Curves.easeInOut,
                      child: Container(
                      height: Responsive.height(60, context),
                      width: Responsive.width(94, context),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: const Folders(
                        title: 'Project \nManagement',
                        titleColor: Colors.black,
                        color: Color(0xFFE2D2F8),
                        numberOfButtons: 2,
                        buttonColor: Color(0xFFDABEFF),
                        buttonTextColor: Colors.black,
                        buttonText: ['Project','Property'],
                                          ),
                      ),),
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
                    child: Container(
                    height: Responsive.height(60, context),
                    width: Responsive.width(94, context),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: const Folders(
                      title: 'Design and\nArchitecture',
                      titleColor: Colors.white,
                      color: Color(0xFFB185EB),
                      numberOfButtons: 3,
                      buttonColor: Color(0xFFA176D9),
                      buttonTextColor: Colors.white,
                      buttonText: ['House','Commericial','Industrial'],
                                        ),
                    ),),
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
                    child: Container(
                    height: Responsive.height(60, context),
                    width: Responsive.width(94, context),
                    child: const Folders(
                    title: 'Real Estate',
                    titleColor: Colors.white,
                    color: Color(0xFF6B4397),
                    description: 'this is a long description that will be added later this is just to see if text wrapping is working and how this will affect spacing',
                    numberOfButtons: 5,
                    buttonColor: Color(0xFF7A4DAC),
                    buttonTextColor: Colors.white,
                    buttonText: ['Buy','Sell','Rent','Lease','Property']
                    
                    )
                    )
                  ),
                  Positioned(top: Responsive.height(42, context),
                  child: Container(
                    height: Responsive.height(60, context),
                    width: Responsive.width(94, context),
                    color:  const Color(0xFF6B4397),
                  )),
                  Positioned(
                    top: Responsive.height(42, context),
                    child: Container(
                    height: Responsive.height(60, context),
                    width: Responsive.width(94, context),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: const Folders(
                      title: 'Swimming Pool',
                      titleColor: Colors.white,
                      color: Color(0xFF34185A),
                      description: 'this is a long description that will be added later this is just to see if text wrapping is working and how this will affect spacing',
                      numberOfButtons: 0,
                      buttonColor: Color(0xFF5E2A8A),
                      buttonTextColor: Colors.white,
                      buttonText: [],
                                        ),
                    ),),
                  ),
                          ])),
          ],
        )),
      ),
    );
  }
}

