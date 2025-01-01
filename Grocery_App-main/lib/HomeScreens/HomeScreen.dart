import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/HomeScreens/CartScreen.dart';
import 'package:grocery_app/HomeScreens/DetailScreen.dart';
import 'package:grocery_app/custom_text/Custom_text.dart';
import 'package:grocery_app/custom_text/custom_textform.dart';
import 'package:grocery_app/custom_text/grideview_category_widget.dart';
import '../custom_text/CustomContainer_Product.dart';
import '../custom_text/Custom_color.dart';
import 'ProductScreen.dart';
import 'ProfileScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // VARIBALE
  String fullname = "Loading";
  final searchcontroller = TextEditingController();

  //FUNCTIONS
  Future<DocumentSnapshot> getcurrentuserinfo() async {
    var currentuser = FirebaseAuth.instance.currentUser;
    return await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentuser!.uid)
        .get();
  }

  //LISTS
  // FOR CAROUSEL
  List carouselbg = [
    'assets/imgs/pastas.jpg',
    'assets/imgs/eggs.jpg',
    'assets/imgs/tomatos.jpg',
  ];
  List caourseltext = [
    'Italian pastas ',
    'Fresh dairy',
    'Fresh Veges',
  ];

  // SCREEN

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getcurrentuserinfo(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasData) {
          final fullname = snapshot.data!['full-name'];
          return Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                leadingWidth: 200,
                leading: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.waving_hand, color: Color(0xffFFCC00)),
                    SizedBox(
                      width: 10,
                    ),
                    CustomText(
                        text: '${'Hello, ' + (fullname)}',
                        size: 18,
                        fontWeight: FontWeight.w600)
                  ],
                ),
                actions: [
                  Row(
                    children: [
                      IconButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen(),));
                      }, icon: Icon(Icons.shopping_cart_outlined,color: Colors.grey.shade600,)),
                      SizedBox(width: 5,),
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: CircleAvatar(
                          backgroundColor: MyColors.primarycolor,
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProfileScreen(),
                                  ));
                            },
                            icon: Icon(Icons.person_outline),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              body: SingleChildScrollView(
                child: SafeArea(
                    child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        child: Column(
                          children: [
                            //SEARCH SECTION
                            CustomTextForm(
                              hinttext: 'Search',
                              controller: searchcontroller,
                              color: Colors.grey.shade300,
                              suffixicon: IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.search_rounded)),
                            ),

                            // CAROUSEL SLIDER
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 15),
                              child: Column(
                                children: [
                                  CarouselSlider.builder(
                                      itemCount: carouselbg.length,
                                      itemBuilder: (context, index, realIndex) {
                                        return GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 20),
                                            width: double.infinity,
                                            height: 300,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              image: DecorationImage(
                                                  colorFilter: ColorFilter.mode(
                                                      Colors.black
                                                          .withOpacity(0.3),
                                                      BlendMode.darken),
                                                  fit: BoxFit.cover,
                                                  image: AssetImage(
                                                      '${carouselbg[index]}')),
                                            ),
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                    child: CustomText(
                                                  text: "Cold Process Organic",
                                                  size: 15,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white,
                                                )),
                                                Positioned(
                                                    top: 20,
                                                    child: CustomText(
                                                      text:
                                                          '${caourseltext[index]}',
                                                      size: 24,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.white,
                                                    )),
                                                Positioned(
                                                    top: 60,
                                                    child: Row(
                                                      children: [
                                                        Icon(Icons.check_circle,
                                                            color: MyColors
                                                                .primarycolor),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        CustomText(
                                                          text:
                                                              'BUY 1 GET 1 FREE',
                                                          size: 16,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: MyColors
                                                              .primarycolor,
                                                        )
                                                      ],
                                                    )),
                                                Positioned(
                                                    bottom: 2,
                                                    child: ElevatedButton(
                                                        style: ElevatedButton.styleFrom(
                                                            backgroundColor:
                                                                Colors.white,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8))),
                                                        onPressed: () {},
                                                        child: CustomText(
                                                          text: 'Shop Now',
                                                          size: 14,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors.black,
                                                        )))
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      options: CarouselOptions(
                                          viewportFraction: 1,
                                          initialPage: 0,
                                          autoPlay: true,
                                          enlargeCenterPage: true,
                                          autoPlayCurve: Curves.easeInOut,
                                          scrollDirection: Axis.horizontal,
                                          autoPlayAnimationDuration:
                                              Duration(milliseconds: 1000)))
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            // CATERGORY SECTION
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: 'Categories',
                                  size: 18,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey.shade600,
                                ),
                                GestureDetector(
                                    onTap: () {},
                                    child: CustomText(
                                      text: 'See all',
                                      size: 12,
                                      fontWeight: FontWeight.w400,
                                      color: MyColors.primarycolor,
                                    ))
                              ],
                            ),
                            SizedBox(
                              height: 3,
                            ),

                            //DO IT IN LISTVIEW BUILDER MUST TOMORROW INSHA ALLAH

                            Container(
                              height: 100,
                              child: StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection("Categories")
                                    .snapshots(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.hasData) {
                                    return ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      physics: ScrollPhysics(),
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: (){
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                  builder: (context) => GridViewWidget(
                                                    collection: snapshot.data!.docs[index]["categoryname"],
                                                    id: snapshot.data!.docs[index].id,
                                                  ),));
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(right: 10),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    margin:
                                                        EdgeInsets.only(right: 5),
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        shape: BoxShape.circle),
                                                    child: CircleAvatar(
                                                      radius: 28,
                                                      backgroundImage:
                                                          NetworkImage(
                                                              snapshot.data!.docs[index]['categoryimage']),
                                                    ),
                                                  ),
                                                  Text(snapshot.data!.docs[index]['categoryname'])
                                                ],
                                              )),
                                        );
                                      },
                                    );
                                  }
                                  if (snapshot.hasError) {
                                    return Center(child: Text("Categories"));
                                  }
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  }

                                  return Container();
                                },
                              ),
                            ),
                            // POPULAR PRODUCTS SECTION
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: 'Products',
                                  size: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => ProductScreen(),));
                                    },
                                    child: CustomText(
                                      text: 'See all',
                                      size: 12,
                                      fontWeight: FontWeight.w400,
                                      color: MyColors.primarycolor,
                                    ))
                              ],
                            ),
                            SizedBox(
                              height: 3,
                            ),
                              Container(
                               height: 240,
                              child: StreamBuilder(
                                stream: FirebaseFirestore.instance.collection("Products").snapshots(),
                                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if(snapshot.hasData){
                                    var items= snapshot.data!.docs;
                                    return ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                        itemCount: items.length < 2 ? items.length :2,
                                        physics: BouncingScrollPhysics(),
                                        itemBuilder:(context, index) {
                                        var data =snapshot.data!.docs[index];
                                          return CustomContainerProduct(
                                            ontap: (){
                                              Navigator.push(context,
                                              MaterialPageRoute(builder: (context) =>
                                                  DetailScreeN(
                                                      productId:  data['ProductId'],
                                                      productImage: data["ProductImage"],
                                                      productName: data["ProductName"],
                                                      productPrice: data["ProductPrice"],
                                                      productOldPrice:data["OldPrice"],
                                                      productRate: data["ProductRate"],
                                                      productDescription: data["ProductDescription"],
                                                  ),));
                                            },
                                              image: snapshot.data!.docs[index]["ProductImage"],
                                              price: snapshot.data!.docs[index]["ProductPrice"],
                                              name: snapshot.data!.docs[index]["ProductName"]
                                          );
                                        },
                                    );
                                  }
                                  return Container();

                                },
                              ),
                            ),


                            // SingleChildScrollView(
                            //   physics: BouncingScrollPhysics(),
                            //   scrollDirection: Axis.horizontal,
                            //   child: Expanded(
                            //     child: Row(
                            //       children: [
                            //         // CustomContainerProduct(),
                            //         // CustomContainerProduct(),
                            //         // CustomContainerProduct(),
                            //         // CustomContainerProduct(),
                            //         // CustomContainerProduct(),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            SizedBox(height: 10,),
                            //BEST SELL PRODUCT SECTION
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: 'Best Sell',
                                  size: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                                GestureDetector(
                                    onTap: () {},
                                    child: CustomText(
                                      text: 'See all',
                                      size: 12,
                                      fontWeight: FontWeight.w400,
                                      color: MyColors.primarycolor,
                                    ))
                              ],
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Container(
                              height: 240,
                              child: StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection("Products")
                                    .where("ProductRate",isGreaterThan: 4.5)
                                    .orderBy("ProductRate",descending: true)
                                    .snapshots(),
                                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if(snapshot.hasData){
                                    return ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: snapshot.data!.docs.length,
                                      physics: BouncingScrollPhysics(),
                                      itemBuilder:(context, index) {
                                        var data=snapshot.data!.docs[index];
                                        return CustomContainerProduct(
                                          ontap: (){
                                            Navigator.push(context, MaterialPageRoute(
                                                builder:(context) => DetailScreeN(
                                                  productId:  data['ProductId'],
                                                  productImage: data["ProductImage"],
                                                  productName: data["ProductName"],
                                                  productPrice: data["ProductPrice"],
                                                  productOldPrice:data["OldPrice"],
                                                  productRate: data["ProductRate"],
                                                  productDescription: data["ProductDescription"],
                                                ), ));
                                          },
                                            image: snapshot.data!.docs[index]["ProductImage"],
                                            price: snapshot.data!.docs[index]["ProductPrice"],
                                            name: snapshot.data!.docs[index]["ProductName"]
                                        );
                                      },
                                    );
                                  }
                                  return Container();

                                },
                              ),
                            ),

                          ],
                        ))),
              ));
        }
        if (snapshot.hasError) {
          return Text('Unable to open app');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Container();
      },
    );
  }
}

// Positioned(
// right: 10,
// // bottom: 0,
// child: Container(
// decoration: BoxDecoration(
// // color: Colors.white,
// image: DecorationImage(
// image: AssetImage(
// '${carouselbg[index]}'),
// fit: BoxFit.cover)),
// width: 140,
// height: 200,
// ),
// ),
// Positioned(
// bottom: 1,
// child: ElevatedButton(
// style: ElevatedButton.styleFrom(
// backgroundColor: Colors.white,
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(11)
// )
// ),
// onPressed: () {},
// child: CustomText(
// text: 'Shop Now',
// size: 12,
// fontWeight: FontWeight.w500,
// color: Colors.black,
// letterspacing: 1,
// )),
// )


// SingleChildScrollView(
//   physics: BouncingScrollPhysics(),
//   scrollDirection: Axis.horizontal,
//   child: Expanded(
//     child: Row(
//       children: [
//         // CustomContainerProduct(),
//         // CustomContainerProduct(),
//         // CustomContainerProduct(),
//         // CustomContainerProduct(),
//         // CustomContainerProduct(),
//       ],
//     ),
//   ),
// ),