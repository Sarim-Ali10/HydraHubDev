import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/HomeScreens/CartScreen.dart';
import 'package:grocery_app/custom_text/Custom_color.dart';
import 'package:grocery_app/custom_text/Custom_text.dart';

class DetailScreeN extends StatefulWidget {
  final String productImage;
  final String productName;
  final double productPrice;
  final double productOldPrice;
  final double productRate;
  final String productDescription;
  final String productId;


  DetailScreeN({required this.productImage, required this.productName, required this.productPrice,
      required this.productOldPrice, required this.productRate,required this.productDescription,required this.productId});



  @override
  State<DetailScreeN> createState() => _DetailScreeNState(
      productImage: productImage,productName: productName,productPrice: productPrice,productOldPrice: productOldPrice,
      productRate: productRate,productDescription:productDescription, productId: productId
  );
}

class _DetailScreeNState extends State<DetailScreeN> {
  final String productImage;
  final String productName;
  final double productPrice;
  final double productOldPrice;
  final double productRate;
  final String productDescription;
  final String productId;


  _DetailScreeNState({required this.productImage,required this.productName,required this.productPrice,
    required this.productOldPrice,required this.productRate,required this.productDescription,required this.productId});

  int count=0;
  void increment(){
    count++;
    setState(() {
    });
  }
  void decrement(){
    count--;
    setState(() {
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 220,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(productImage)
                        ),
                          color: Colors.grey
                      ),
                    ),
                    Positioned(
                        top: 8,
                        left: 5,
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back_ios_new_outlined,
                              color: Colors.black,
                              size: 24,
                            )))
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                            text: productName,
                            size: 18,
                            fontWeight: FontWeight.w600),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                                text: 'Rs ${productPrice}',
                                size: 16,
                                fontWeight: FontWeight.w600,
                                color: MyColors.primarycolor,
                            ),
                            CustomText(text: 'Rating: ${productRate}', size: 14, fontWeight: FontWeight.w600,color: MyColors.primarycolor,)
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        CustomText(
                            text: 'Description',
                            size: 16,
                            fontWeight: FontWeight.w600),
                        CustomText(
                            text:
                                productDescription,
                            size: 12,
                            fontWeight: FontWeight.normal,
                        color:Colors.grey,

                        ),
                        SizedBox(height: 15,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomText(
                                text: "Quantity :", size: 14, fontWeight: FontWeight.w600),
                            Container(
                              margin: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(color: Colors.black)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        if (count <= 0) {

                                        } else {
                                          decrement();
                                        }
                                      },
                                      icon: Icon(Icons.remove)),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 12, right: 12, top: 2, bottom: 2),
                                    child: Text('${count}'),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        increment();
                                      },
                                      icon: Icon(Icons.add))
                                ],
                              ),
                            ),

                          ],
                        ),
                        SizedBox(height: 15,),
                        Row(
                          children: [
                            CustomText(text: 'Total Price: ', size: 16, fontWeight: FontWeight.w600),
                            CustomText(text: '${count*widget.productPrice}', size: 18, fontWeight: FontWeight.w400)
                          ],
                        ),
                        SizedBox(height: 15,),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: MyColors.primarycolor,
                                side: BorderSide(
                                    width: 1,
                                    color: Colors.grey.shade500
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10)
                                )
                            ),
                            onPressed: () {
                              if(count>0){
                                FirebaseFirestore.instance
                                    .collection('Cart')
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .collection("UserCart").doc(productId)
                                    .set({
                                  "productId":productId ,
                                  "productImage":productImage,
                                  "productName":productName,
                                  "productPrice":productPrice,
                                  "productOldPrice":productOldPrice,
                                  "productRate":productRate,
                                  "productDescription":productDescription,
                                  "productQuantity":count,

                                });
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Item Added to cart')));
                                Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen(),));
                              }
                              else{
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please Select Quantity')));
                              }



                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 15),
                              child: CustomText(text: 'Add to Cart',
                                size: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,),
                            )),

                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
