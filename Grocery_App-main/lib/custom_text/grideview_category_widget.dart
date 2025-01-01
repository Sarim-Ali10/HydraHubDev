import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/HomeScreens/DetailScreen.dart';
import 'package:grocery_app/custom_text/CustomContainer_Product.dart';
import 'package:grocery_app/custom_text/Custom_text.dart';

import 'custom_textform.dart';

class GridViewWidget extends StatelessWidget {

  final String id;
  final String collection;
  final searchcontroller=TextEditingController();


  GridViewWidget({required this.id, required this.collection});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        },icon: Icon(Icons.arrow_back_ios_new_outlined),),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Categories")
            .doc(id)
            .collection(collection)
            .snapshots(),
          builder:(context,snapshot) {
          if(snapshot.hasData){
            return Container(
              height: double.infinity,
              width: double.infinity,
              margin: EdgeInsets.only(left: 10),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextForm(
                      hinttext: 'Search',
                      controller: searchcontroller,
                      color: Colors.grey.shade300,
                      suffixicon: IconButton(
                          onPressed: () {
                          }, icon: Icon(Icons.search_rounded)),
                    ),
                  ),
                  SizedBox(height: 20,),
                  GridView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: BouncingScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent:250,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      var data=snapshot.data!.docs[index];
                      return CustomContainerProduct(
                        ontap: (){
                          Navigator.push(context, MaterialPageRoute(
                              builder:(context) =>DetailScreeN(
                                  productId:  data['ProductId'],
                                  productImage: data['ProductImage'],
                                  productName: data['ProductName'],
                                  productPrice: data['ProductPrice'],
                                  productOldPrice: data['OldPrice'],
                                  productRate: data['ProductRate'],
                                  productDescription: data['ProductDescription']) , ));
                        },
                        image: data["ProductImage"],
                        price: data["ProductPrice"],
                        name:  data["ProductName"],
                      );
                    },),
                ],
              ),
            );
          }
          if(snapshot.hasError){
            return Center(child: Text("Error from gridviewclass"),);
          }
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }
          return Container();


          },
      )
    );
  }
}

