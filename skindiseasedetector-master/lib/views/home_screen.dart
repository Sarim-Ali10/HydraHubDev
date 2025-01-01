import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:skindiseasedetector/constants/colors.dart';
import 'package:skindiseasedetector/constants/size_config.dart';
import 'package:skindiseasedetector/views/product_description_screen.dart';

import '../reuseablewidgets/face_scanning_container.dart';
import '../reuseablewidgets/product_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final List<String> productImages = ['images/productImages/serum1.jpg','images/productImages/serum2.jpg','images/productImages/serum3.jpg'];
  final List<String> productTitle = ['Glow Recipe Strawberry Smooth BHA +','La Roche-Posay Hyalu B5', 'Hyaluronic + Peptide 24'];
  final List<String> productPrice = ['25000','14000', '23000'];
  final List<String> productAvailability = ['In Stock','Out of Stock', 'In Stock'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      drawer: const Drawer(),
      body: SafeArea(
        top: true,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 14),
          width: SizeConfig.screenWidth * 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(
                width: SizeConfig.screenWidth * 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    IconButton(onPressed: (){}, icon: const Icon(Iconsax.category)),

                    Text('AI Care',style: TextStyle(fontSize: SizeConfig.textMultiplier * 2, fontWeight: FontWeight.w600,color: primaryColor),overflow: TextOverflow.fade,),


                    IconButton(onPressed: (){}, icon: const Icon(Iconsax.message4))
                  ],
                ),
              ),


              // Face Scanning Container
              const FaceScanningContainer(),

              SizedBox(
                height: SizeConfig.blockSizeVertical * 2,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text('Top Selling',style: TextStyle(fontSize: SizeConfig.textMultiplier * 2, fontWeight: FontWeight.w600,color: primaryColor),),
                Text('see more',style: TextStyle(fontSize: SizeConfig.textMultiplier * 1.5, fontWeight: FontWeight.w400,color: primaryColor),),
                ],
              ),

              // Product Listing

              SizedBox(
                width: SizeConfig.screenWidth * 1,
                height: SizeConfig.screenHeight * 0.5,
                child: SingleChildScrollView(
                  physics: const ScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child: ListView.builder(
                    itemCount: productImages.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: const ScrollPhysics(),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const ProductDescriptionScreen(),));
                        },
                        child: ProductContainer(
                          productImage: productImages[index],
                          productTitle: productTitle[index],
                          productCategory: 'Beauty',
                          productPrice: '${productPrice[index]} PKR',
                          productAvailability: productAvailability[index],
                        ),
                      );
                    },),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}


