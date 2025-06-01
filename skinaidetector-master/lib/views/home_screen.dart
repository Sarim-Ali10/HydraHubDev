import 'dart:io';

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:skinai/appservices/location_services.dart';
import 'package:skinai/constants/colors.dart';
import 'package:skinai/constants/size_config.dart';
import 'package:skinai/reuseablewidgets/face_scanner_dialog.dart';
import 'package:skinai/views/chat_screen.dart';
import 'package:skinai/views/login_screen.dart';
import 'package:skinai/views/product_description_screen.dart';
import 'package:skinai/views/doctors_screen.dart';
import 'package:skinai/views/product_screen.dart';
import 'package:skinai/views/profile_screen.dart';
import '../reuseablewidgets/face_scanning_container.dart';
import '../reuseablewidgets/product_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> productImages = [
    'images/productImages/serum1.jpg',
    'images/productImages/serum2.jpg',
    'images/productImages/serum3.jpg'
  ];
  final List<String> productTitle = [
    'Glow Recipe Strawberry Smooth BHA +',
    'La Roche-Posay Hyalu B5',
    'Hyaluronic + Peptide 24'
  ];
  final List<int> productPrice = [25000, 14000, 23000];
  final List<String> productAvailability = [
    'In Stock',
    'Out of Stock',
    'In Stock'
  ];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final LocationService locationService = LocationService();

  int _selectedIndex = 0;

  void _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  void initState() {
    locationService.getCurrentLocation();
    super.initState();
  }

  Widget _buildHomeTab() {
    return SafeArea(
      top: true,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 14),
        width: SizeConfig.screenWidth * 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App bar area
            SizedBox(
              width: SizeConfig.screenWidth * 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ChatScreen()),
                      );
                    },
                    icon: const Icon(Iconsax.message),
                  ),
                  Text(
                    'HYDRA HUB',
                    style: TextStyle(
                      fontSize: SizeConfig.textMultiplier * 2,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                    overflow: TextOverflow.fade,
                  ),
                  IconButton(
                    onPressed: _logout,
                    icon: const Icon(Iconsax.logout),
                  ),
                ],
              ),
            ),

            const FaceScanningContainer(),

            SizedBox(height: SizeConfig.blockSizeVertical * 2),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Top Selling',
                  style: TextStyle(
                    fontSize: SizeConfig.textMultiplier * 2,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ],
            ),

            SizedBox(
              width: SizeConfig.screenWidth * 1,
              height: SizeConfig.screenHeight * 0.45, // reduced from 0.5
              child: CustomScrollView(
                physics: const ScrollPhysics(),
                scrollDirection: Axis.vertical,
                slivers: [
                  SliverAnimatedList(
                    itemBuilder: (context, index, animation) {
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
                        child: ProductContainer(
                          productImage: productImages[index],
                          productTitle: productTitle[index],
                          productCategory: 'Beauty',
                          productPrice: '${productPrice[index]} PKR',
                          productAvailability: productAvailability[index],
                        ),
                      );
                    },
                    initialItemCount: productTitle.length,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return _buildHomeTab();
      case 1:
        return ProductListScreen();
      case 2:
        return const FaceScannerDialog();
      case 3:
        return const AllDoctorsScreen();
      case 4:
        return  ProfilePage();
      default:
        return _buildHomeTab();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) => exit(0),
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: secondaryColor,
        drawer: const Drawer(),
        body: _buildBody(),
        bottomNavigationBar: ConvexAppBar(
          backgroundColor: Colors.white,
          activeColor: successColor,
          color: Colors.grey,
          style: TabStyle.fixedCircle,
           height: 60,
          elevation: 0,
          cornerRadius: 21,

          initialActiveIndex: _selectedIndex,
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: const [
            TabItem(icon: Iconsax.home, title: 'Home'),
            TabItem(icon: Iconsax.shop, title: 'Products'),
            TabItem(icon: Iconsax.scan,title: 'Scan'), // center big button
            TabItem(icon: Iconsax.hospital, title: 'Doctors'),
            TabItem(icon: Iconsax.user, title: 'Profile'),
          ],
        ),
      ),
    );
  }
  }
