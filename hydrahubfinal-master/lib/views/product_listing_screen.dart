import 'package:flutter/material.dart';
import 'package:skindiseasedetector/views/product_description_screen.dart';

class ProductListingScreen extends StatelessWidget {
  ProductListingScreen({Key? key}) : super(key: key);
  final List<Map<String, String>> products = [
    {
      "name": "Serum 1",
      "price": "\$50.00",
      "image": "images/productImages/serum2.jpg"
    },
    {
      "name": "Serum 2",
      "price": "\$20.00",
      "image": "Assets/Images/pg2.jpeg"
    },
    {
      "name": "Serum3",
      "price": "\$30.00",
      "image": "images/productImages/serum1.jpg"
    },
    {
      "name": "Serum 4",
      "price": "\$20.00",
      "image": "images/productImages/serum2.jpg"
    },
    {
      "name": "Serum 5",
      "price": "\$40.00",
      "image": "Assets/Images/pg2.jpeg"
    },
    {
      "name": "Serum 6",
      "price": "\$60.00",
      "image": "images/productImages/serum2.jpg"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFf6f6f6),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
                child: Icon(Icons.arrow_back)),
            SizedBox(height: 15,),
            Row(
              children: [
                Text('Products',style: TextStyle(fontFamily: 'Zolina',fontSize: 24),)
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "30 Items",
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.sort, size: 18, color: Colors.black),
                  label: const Text(
                    "Recently added",
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),

            // Product Grid
            Expanded(
              child: GridView.builder(
                itemCount: products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  final product = products[index];
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDescriptionScreen(),));
                    },
                    child: ProductCard(
                      productName: product["name"]!,
                      productPrice: product["price"]!,
                      productImage: product["image"]!,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

    );
  }
}

class ProductCard extends StatelessWidget {
  final String productName;
  final String productPrice;
  final String productImage;

  const ProductCard({
    Key? key,
    required this.productName,
    required this.productPrice,
    required this.productImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey[100],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(21)),
              child: Image.asset(
                productImage,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productName,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  productPrice,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
