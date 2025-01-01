import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../HomeScreens/HomeScreen.dart';
import '../UserAuthentication/LoginScreen.dart';
import '../custom_text/Custom_color.dart';
import '../custom_text/Custom_text.dart';
import 'intropage1.dart';
import 'intropage2.dart';
import 'intropage3.dart';


class PageViewScreen extends StatefulWidget {
  const PageViewScreen({super.key});

  @override
  State<PageViewScreen> createState() => _PageViewScreenState();
}

class _PageViewScreenState extends State<PageViewScreen> {
  final PageController _controller = PageController();
  bool lastpage=false;


  @override
  void dispose() {
    _controller.dispose(); // Dispose PageController to avoid memory leaks
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          PageView(
            controller: _controller,
              onPageChanged: (index){
              WidgetsBinding.instance.addPostFrameCallback((_){
                setState(() {
                  lastpage=(index==2);
                });
              });
          },
          children:const [
            IntroPage1(),
            IntroPage2(),
            IntroPage3(),
          ],
        ),
          lastpage ? Positioned(
            bottom: screenHeight * 0.09,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 100,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black,width: 1),
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: GestureDetector(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                    },
                    child: Center(child: Text('Done',style: TextStyle(fontSize: 14,fontFamily: 'Zolina',fontWeight: FontWeight.w400,color: Colors.white),))),
              ),
            ),)
              :
          Positioned(
            bottom: screenHeight * 0.09,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black,width: 1),
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: GestureDetector(
                  onTap: (){
                    _controller.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
                  },
                    child: Icon(Icons.arrow_forward_ios_outlined)),
              ),
            ),),

        ]
      ),
    );
  }
}