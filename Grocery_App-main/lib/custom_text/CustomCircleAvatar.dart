import 'package:flutter/material.dart';
import 'package:grocery_app/custom_text/Custom_color.dart';

import 'Custom_text.dart';
class MyCircle extends StatelessWidget {
  final IconButton iconButton;
  final String categoryname;
  const MyCircle({super.key,required this.iconButton,required this.categoryname});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: CircleAvatar(
              backgroundColor: MyColors.primarycolor,
              child: Center(
                child: IconButton(
                  onPressed: (){

                  },
                  icon: iconButton,
                ),
              ),
            ),
          ),
          CustomText(text: categoryname, size: 14, fontWeight: FontWeight.w400)
        ],
      ),
    );
  }
}
