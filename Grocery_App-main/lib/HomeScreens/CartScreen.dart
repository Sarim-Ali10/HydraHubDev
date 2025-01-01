import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/HomeScreens/HomeScreen.dart';
import 'package:grocery_app/custom_text/Custom_text.dart';

import '../custom_text/CustomCart_Card.dart';
import '../custom_text/Custom_color.dart';
import 'CheckOutScreen.dart';

class CartScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:  SizedBox(
        width: 50,
        child: ElevatedButton(
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => CheckOutScreen(),));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 10, horizontal: 20),
              child: CustomText(text: 'Check Out',
                size: 16,
                fontWeight: FontWeight.w400,
                color: Colors.white,),
            )),
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 100,
        leading: GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
          },
          child: Row(
            children: [
                  Icon(Icons.arrow_back_ios_new_outlined),
                  CustomText(text: 'Back', size: 16, fontWeight: FontWeight.w600)
            ], 
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText(text: 'My Cart', size: 18, fontWeight: FontWeight.w600),
          ],
        ),
      ),
      body: StreamBuilder(
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
                return CartCard(
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
    );
  }
}
