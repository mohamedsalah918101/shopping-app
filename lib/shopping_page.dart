import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shopping_app/profile_page.dart';

import 'login_page.dart';

class ShoppingPage extends StatefulWidget {
  const ShoppingPage({super.key});

  @override
  State<ShoppingPage> createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {
  final LocalAuthentication auth = LocalAuthentication();

  final List<String> productImages = [
    'assets/images/tv.jpg',
    'assets/images/tablet.jpg',
    'assets/images/laptop.webp',
  ];

  final List<Map<String, dynamic>> gridProducts = [
    {'name': 'Laptop', 'price': '\$999', 'image': 'assets/images/laptop.webp'},
    {
      'name': 'Smartphone',
      'price': '\$699',
      'image': 'assets/images/smartphone.jpg'
    },
    {
      'name': 'Headphones',
      'price': '\$199',
      'image': 'assets/images/headphones.webp'
    },
    {'name': 'Tablet', 'price': '\$499', 'image': 'assets/images/tablet.jpg'},
  ];

  final List<Map<String, dynamic>> hotOffers = [
    {
      'name': 'Special Deal 1',
      'discount': '30% OFF',
      'image': 'assets/images/laptop.webp'
    },
    {
      'name': 'Special Deal 2',
      'discount': '25% OFF',
      'image': 'assets/images/smartphone.jpg'
    },
    {
      'name': 'Special Deal 3',
      'discount': '40% OFF',
      'image': 'assets/images/headphones.webp'
    },
    {
      'name': 'Special Deal 4',
      'discount': '20% OFF',
      'image': 'assets/images/tablet.jpg'
    },
    {
      'name': 'Special Deal 5',
      'discount': '35% OFF',
      'image': 'assets/images/tv.jpg'
    },
  ];

  Future<void> authenticateAndNavigate() async {
    try {
      bool isAuthenticated = await auth.authenticate(
          localizedReason: 'Scan your fingerprint to access your profile',
          options: AuthenticationOptions(biometricOnly: true));
      if (isAuthenticated) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfilePage(),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Authentication failed. Try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 5,
        automaticallyImplyLeading: false,
        title: Text(
          tr('shopping_app_title'),
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ));
          },
          icon: Icon(
            Icons.logout,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: authenticateAndNavigate,
            icon: const Icon(Icons.account_circle, color: Colors.white, size: 30),
          ),
          IconButton(
            onPressed: () {
              // To switch the Languages between Arabic and English
              changeLanguage();
            },
            icon: Icon(
              Icons.language,
              size: 30,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                tr('our_products'),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),

            SizedBox(
              height: screenHeight * 0.25,
              // PageView
              child: pageViewUI(),
            ),

            // GridView
            gridViewUI(),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(tr('hot_offers'),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: screenHeight * 0.2,
              //ListView
              child: listViewUI(),
            ),
          ],
        ),
      ),
    );
  }

  Widget pageViewUI() {
    return PageView.builder(
      itemCount: productImages.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              image: AssetImage(productImages[index]),
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }

  Widget gridViewUI() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.75,
      ),
      itemCount: gridProducts.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(gridProducts[index]['image']),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          gridProducts[index]['name'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(gridProducts[index]['price']),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_shopping_cart),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                '${gridProducts[index]['name']} added to cart'),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget listViewUI() {
    final screenWidth = MediaQuery.of(context).size.width;

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: hotOffers.length,
      itemBuilder: (context, index) {
        return Container(
          width: screenWidth * 0.4,
          margin: const EdgeInsets.only(left: 16),
          child: Card(
            child: Column(
              children: [
                Expanded(
                  child: Image.asset(
                    hotOffers[index]['image'],
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        hotOffers[index]['name'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        hotOffers[index]['discount'],
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  changeLanguage() {
    if (context.locale == Locale('en', 'US')) {
      context.setLocale(Locale('ar', 'EG'));
    } else {
      context.setLocale(Locale('en', 'US'));
    }
  }
}
