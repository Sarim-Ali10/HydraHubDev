import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/custom_text/Custom_CheckOut_Card.dart';
import 'package:grocery_app/custom_text/Custom_color.dart';
import 'package:grocery_app/custom_text/Custom_text.dart';

import '../custom_text/CustomCart_Card.dart';

class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        // centerTitle: true,
        leadingWidth: 150,
        leading: Row(
          children: [
            IconButton(onPressed: (){
              Navigator.pop(context);
            }, icon: Icon(Icons.arrow_back_ios_new_outlined,size: 18,)),
            SizedBox(width: 5,),
            CustomText(text: 'View Cart', size: 16, fontWeight: FontWeight.normal,color: MyColors.primarycolor,)
          ],
        ),
      ),
      body: SafeArea(
        child:Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection("Cart")
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection("UserCart").snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if(snapshot.hasData){
                    return snapshot.data!.docs.isEmpty
                        ? Center(child: Text('Your Cart is Empty'),)
                        : ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      physics: BouncingScrollPhysics(),
                      itemBuilder:(context, index) {
                        var data =snapshot.data!.docs[index];
                        return CheckOutCard(
                            productId: data['productId'],
                            productImage: data['productImage'],
                            productPrice: data['productPrice'],
                            productQuantity:data['productQuantity'],
                            productName: data['productName'],
                        );
                      },
                    );

                  }
                  if(snapshot.hasError){
                    return Center(child: Text("Error from  Cart Screen"),);
                  }
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(child: CircularProgressIndicator(),);
                  }
                  return Container();

                },

              ),
            ),

            Stack(
              children:[
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 0,left: 5,right: 5,bottom: 5),
                    padding: EdgeInsets.only(top: 20, left: 20, right: 20,bottom: 10),
                    decoration: BoxDecoration(
                      color: Color(0xC7D2FDBB),
                      borderRadius: BorderRadius.circular(36)
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(text: 'Total Amount', size: 16, fontWeight: FontWeight.normal,color: Colors.grey.shade600,),
                            CustomText(text: 'Rs. 23', size: 16, fontWeight: FontWeight.bold,color: Colors.black,)
                          ],
                        ),
                        SizedBox(height: 8,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(text: 'Delivery Charge', size: 16, fontWeight: FontWeight.normal,color: Colors.grey.shade600,),
                            CustomText(text: 'Rs. 100', size: 16, fontWeight: FontWeight.bold,color: Colors.black,)
                          ],
                        ),
                        SizedBox(height: 8,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(text: 'Discount', size: 16, fontWeight: FontWeight.normal,color: Colors.grey.shade600,),
                            CustomText(text: '%5', size: 16, fontWeight: FontWeight.bold,color: Colors.black,)
                          ],
                        ),
                        SizedBox(height: 20,),
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
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(text: 'Sub Total', size: 16, fontWeight: FontWeight.normal),
                            CustomText(text: 'Rs. 200', size: 16, fontWeight: FontWeight.bold,color: Colors.black,)
                          ],
                        ),
                        SizedBox(height: 10,),
                        Positioned(
                          bottom: 20,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    side: BorderSide(width: 1,
                                    color: MyColors.primarycolor
                                    ),
                                      backgroundColor: Color(0x9405EF1B),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              10),
                                      )
                                  ),
                                  onPressed: () {

                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 80),
                                    child: CustomText(text: 'Continue',
                                      size: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,),
                                  )),
                            ],
                          ),
                        ),

                      ],
                    ),
              ))
             ],
            ),
          ],
        ),



      ),
    );
  }
}



