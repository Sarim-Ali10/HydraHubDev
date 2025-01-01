import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

import 'Custom_text.dart';

class CheckOutCard extends StatefulWidget {
  var productImage;
  var productName;
  var productPrice;
  var productQuantity;
  var productId;


  CheckOutCard({ required this.productImage,required this.productName,required this.productPrice,
     required this.productQuantity,required this.productId});

  @override
  State<CheckOutCard> createState() => _CheckOutCardState();
}

class _CheckOutCardState extends State<CheckOutCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      decoration: BoxDecoration(
        // color: Colors.red,
      ),
      child:Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
              flex:2,
              child: Container(
                height: 100,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      color: Colors.grey.shade200,
                      image: DecorationImage(
                          image: NetworkImage(widget.productImage),
                          fit: BoxFit.contain
                      )
                  ),
                ),

              )),
          Expanded(
            flex:4,
            child: Container(
              padding: EdgeInsets.all(10),
              // color: Colors.red,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(text: widget.productName, size: 16, fontWeight: FontWeight.w600),
                  CustomText(text: 'Veg', size: 14, fontWeight: FontWeight.normal),
                  Row(
                    children: [
                      CustomText(text: 'Rs ${widget.productPrice}', size: 14, fontWeight: FontWeight.normal),
                      Container(
                        margin: EdgeInsets.only(left:8),
                        decoration: BoxDecoration(

                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 12, right: 12, top: 3, bottom: 3),
                          child: CustomText(text:'x ${widget.productQuantity}',size: 14,fontWeight: FontWeight.bold,color: Colors.black38,),
                        ),
                      ),
                    ],
                  ),
                  DottedLine(
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.center,
                    lineLength: double.infinity,
                    lineThickness: 2.0,
                    dashLength: 10.0,
                    dashColor: Colors.grey.shade300,
                    // dashGradient: [Colors.red, Colors.blue],
                    dashRadius: 10.0,
                    dashGapLength: 10.0,
                    dashGapColor: Colors.transparent,
                    // dashGapGradient: [Colors.red, Colors.blue],
                    dashGapRadius: 10.0,
                  ),

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
