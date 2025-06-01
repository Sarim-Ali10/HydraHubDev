import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:skinai/constants/colors.dart';
import 'package:skinai/constants/size_config.dart';
import 'product_description_screen.dart';

class ProductListScreen extends StatelessWidget {
  final List<String> productImages = [
    'images/productImages/serum1.jpg',
    'images/productImages/serum2.jpg',
    'images/productImages/serum3.jpg',
    'images/productImages/serum1.jpg',
    'images/productImages/serum2.jpg',
    'images/productImages/serum3.jpg'
  ];

  final List<String> productTitle = [
    'Glow Recipe Strawberry Smooth BHA +',
    'La Roche-Posay Hyalu B5',
    'Hyaluronic + Peptide 24',
    'Glow Recipe Strawberry Smooth BHA +',
    'La Roche-Posay Hyalu B5',
    'Hyaluronic + Peptide 24'
  ];

  final List<int> productPrice = [
    25000, 14000, 23000, 25000, 14000, 23000
  ];

  final List<String> productAvailability = [
    'In Stock',
    'Out of Stock',
    'In Stock',
    'In Stock',
    'Out of Stock',
    'In Stock'
  ];


  ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: const Text(
          'Products',
          style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 20),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 10),
        child: GridView.builder(
          itemCount: productImages.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDescriptionScreen(
                      image: productImages[index],
                      title: productTitle[index],
                      stock: productAvailability[index],
                      productPrice: productPrice[index],
                    ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                        child: Image.asset(
                          productImages[index],
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (productAvailability[index] == 'In Stock')
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: successColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                'New',
                                style: TextStyle(fontSize: 10, color: Colors.white),
                              ),
                            ),
                          const SizedBox(height: 4),
                          Text(
                            productTitle[index],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${productPrice[index]} PKR',
                            style: const TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
