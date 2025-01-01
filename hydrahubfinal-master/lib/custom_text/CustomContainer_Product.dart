import 'package:flutter/material.dart';

import 'Custom_color.dart';
import 'Custom_text.dart';

class CustomContainerProduct extends StatelessWidget {
 final String image;
 final double price;
 final String name;
 Function()? ontap;



 CustomContainerProduct({required this.image, required this.price, required this.name,this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:ontap ,
      child: Container(
        margin: EdgeInsets.only(right: 10),
        padding: EdgeInsets.all(4),
        height: 220,
        width: 180,
        decoration: BoxDecoration(
            color: Colors.white60,
            borderRadius: BorderRadius.circular(13),
            border: Border.all(color: Colors.grey.shade300,width: 1)
        ),
        child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.all(5),
                  // padding: EdgeInsets.all(5),
                  height: 160,
                  width: 160,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(13),
                      border: Border.all(color: Colors.grey.shade100,width: 0.7),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(image),
                      )

                  ),
                ),
                Container(
                    margin: EdgeInsets.only(left: 10,top: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(text: name, size: 16, fontWeight: FontWeight.w400),
                        CustomText(text: '\Rs $price', size: 14, fontWeight: FontWeight.w600,color: MyColors.primarycolor),
                      ],
                    )),
              ]
          ),
      ),
    );
  }
}
