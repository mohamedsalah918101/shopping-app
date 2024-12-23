import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
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

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Shopping App',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Our Products',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.25,
              child: PageView.builder(
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
              ),
            ),
            GridView.builder(
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
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
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
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Hot Offers 🔥',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: screenHeight * 0.2,
              child: ListView.builder(
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
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
