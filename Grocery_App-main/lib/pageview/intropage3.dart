import 'package:flutter/material.dart';

import '../custom_text/Custom_text.dart';

class IntroPage3 extends StatefulWidget {
  const IntroPage3({super.key});

  @override
  State<IntroPage3> createState() => _IntroPage3State();
}

class _IntroPage3State extends State<IntroPage3> {
  double _angle=50;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child:Stack(
              children:[
                Container(
                  width: double.infinity,
                  color: Colors.grey.shade200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 30,vertical: 60),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                  text: 'Fresh Dairy', size: 34, fontWeight: FontWeight.w600),
                              CustomText(
                                  text: 'will fulfill your', size: 34, fontWeight: FontWeight.w600),
                              CustomText(text: 'lifes needs ', size: 34, fontWeight: FontWeight.w600),
                              SizedBox(height: 20,),
                              CustomText(text: 'Vegetables Are Important Sources Of\n Many Nutrients, Including Potassium,\n Dietary Fibre, Floate(Folic Acid)\n Vitamin A, And Vitamin C',                   size: 14, fontWeight: FontWeight.w400,color: Colors.grey.shade600,),
                              Container(
                                margin: EdgeInsets.only(bottom: 30),
                                decoration:BoxDecoration(
                                ),)
                            ],
                          )),

                    ],
                  ),
                ),
                Positioned(
                    bottom: 1,
                    // right: -50,
                    child: Transform.rotate(
                      angle: _angle,
                      child: Container(
                        width: 500,
                        height: 400,
                        decoration: BoxDecoration(
                          // color: Colors.red,
                            image: DecorationImage(
                                image: AssetImage('assets/imgs/pg3.png')
                            )
                        ),
                      ),
                    ))
              ]
          )
      ),
    );
  }
}
