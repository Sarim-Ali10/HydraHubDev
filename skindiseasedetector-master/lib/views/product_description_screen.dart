import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:skindiseasedetector/constants/colors.dart';
import 'package:skindiseasedetector/constants/size_config.dart';

class ProductDescriptionScreen extends StatefulWidget {
  const ProductDescriptionScreen({super.key});

  @override
  State<ProductDescriptionScreen> createState() => _ProductDescriptionScreenState();
}

class _ProductDescriptionScreenState extends State<ProductDescriptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: SafeArea(
        top: true,
        child: Container(
          width: SizeConfig.screenWidth * 1,
          margin: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(
                height: SizeConfig.heightMultiplier * 2,
              ),

              Stack(
                children: [

                  // Background Support Container

                  SizedBox(
                    width: SizeConfig.screenWidth * 1,
                    height: SizeConfig.screenHeight * 0.38,
                  ),

                  // Image Container
                  Container(
                    width: SizeConfig.screenWidth * 1,
                    height: SizeConfig.screenHeight * 0.38,
                    decoration: BoxDecoration(
                        color: primaryColor.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(20),
                      image:const DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('images/productImages/serum2.jpg')),
                    ),
                  ),

                  // Icons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(onPressed: (){
                        Navigator.pop(context);
                      }, icon: const Icon(Iconsax.arrow_left,color: primaryColor,size: 30,)),
                      IconButton(onPressed: (){}, icon: const Icon(Iconsax.shopping_cart,color: primaryColor,size: 30,)),
                    ],
                  ),

                  Positioned(
                      top: 240,
                      left: 16,
                      child: Container(
                    decoration: BoxDecoration(
                      color: successColor,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 4),
                    child: Text('In Stock',style: TextStyle(fontSize: SizeConfig.textMultiplier * 1.4, fontWeight: FontWeight.w800,color: secondaryColor)),
                  )),

                  Positioned(
                    top: 240,
                    child: Container(
                      width: SizeConfig.screenWidth * 1,
                      height: SizeConfig.screenHeight * 0.12,
                      alignment: Alignment.bottomLeft,
                      padding: const EdgeInsets.only(left: 20,bottom: 20),
                      child: SizedBox(
                          width: SizeConfig.screenWidth * 0.8,
                          child: Text('Glow Recipe Strawberry Smooth BHA +',style: TextStyle(fontSize: SizeConfig.textMultiplier * 2.2, fontWeight: FontWeight.w800,color: primaryColor),maxLines: 2,overflow: TextOverflow.ellipsis,)),
                    ),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('65000 PKR',style: TextStyle(fontSize: SizeConfig.textMultiplier * 2, fontWeight: FontWeight.w800,color: primaryColor)),

                  Row(
                    children: [
                      Container(
                        width: SizeConfig.screenWidth * 0.08,
                        height: SizeConfig.screenHeight * 0.08,
                        decoration: const BoxDecoration(
                            color: accentColor,
                            shape: BoxShape.circle
                        ),
                        child: const Icon(Iconsax.minus,color: secondaryColor,),
                      ),

                      SizedBox(
                        width: SizeConfig.widthMultiplier * 6,
                      ),

                      Text('1',style: TextStyle(fontSize: SizeConfig.textMultiplier * 2, fontWeight: FontWeight.w600,color: primaryColor.withOpacity(0.6))),

                      SizedBox(
                        width: SizeConfig.widthMultiplier * 6,
                      ),

                      Container(
                        width: SizeConfig.screenWidth * 0.08,
                        height: SizeConfig.screenHeight * 0.08,
                        decoration: const BoxDecoration(
                            color: accentColor,
                            shape: BoxShape.circle
                        ),
                        child: const Icon(Iconsax.add,color: secondaryColor,),
                      )
                    ],
                  )
                ],
              ),

              Container(
                width: SizeConfig.screenWidth * 1,
                height: SizeConfig.screenHeight * 0.36,
                decoration: BoxDecoration(
                  color: secondaryColor,
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 6
                    )
                  ],
                  borderRadius: BorderRadius.circular(20)
                ),
                child: SingleChildScrollView(
                  physics: const ScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.all(10),
                  child: Text('jghkjdshgkdfslksjdklsdfjdjslfkhg',
                      style: TextStyle(
                          fontSize: SizeConfig.textMultiplier * 1.7,
                          fontWeight: FontWeight.w400,
                          color: primaryColor)),
                ),
              )

            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        alignment: Alignment.center,
        height: SizeConfig.screenHeight * 0.06,
        margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
        decoration: BoxDecoration(
          color: accentColor,
          borderRadius: BorderRadius.circular(40)
        ),
        child: Text('Buy Now',style: TextStyle(fontSize: SizeConfig.textMultiplier * 2, fontWeight: FontWeight.w600,color: secondaryColor)),
      ),
    );
  }
}
