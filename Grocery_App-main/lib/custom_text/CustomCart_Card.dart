import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Custom_text.dart';


class CartCard extends StatefulWidget {
  var productImage;
  var productName;
  var productPrice;
  var productQuantity;
  var productId;


  CartCard({required this.productImage,required this.productName,required this.productPrice,
    required this.productQuantity,required this.productId});

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  void deleteProductFun(){
    FirebaseFirestore.instance
        .collection('Cart')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('UserCart')
        .doc(widget.productId)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.all(10),
      // padding: EdgeInsets.symmetric(vertical: 5),
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(6)
      ),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.white,
                        image: DecorationImage(
                            image: NetworkImage(widget.productImage),
                            fit: BoxFit.contain
                        )
                    ),
                  )),
              Expanded(
                flex: 4,
                child: Container(

                  margin: EdgeInsets.only(left: 8),
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(text: widget.productName, size: 18, fontWeight: FontWeight.normal),
                      CustomText(text: 'Meat', size: 16, fontWeight: FontWeight.normal),
                      Row(
                        children: [
                          CustomText(text: 'Rs ${widget.productPrice}', size: 14, fontWeight: FontWeight.w600),
                          Container(
                            margin: EdgeInsets.only(left:8),
                            decoration: BoxDecoration(

                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 12, right: 12, top: 3, bottom: 3),
                              child: CustomText(text:'x  '+widget.productQuantity.toString(),size: 16,fontWeight: FontWeight.bold,color: Colors.black38,),
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
          IconButton(onPressed: (){
            deleteProductFun();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Item removed from Cart')));

          }, icon: Icon(Icons.cancel,color: Colors.grey,))
        ],
      )
    );
  }
}
