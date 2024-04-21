import 'package:dio/dio.dart';
import 'package:fake_store_assignment/Config/app_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Controller/product_provider.dart';
import '../../Model/product_model.dart';
import '../Widgets/product_tiles.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key,});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Product>> getData() async {
    try {
      Dio dio = Dio();
      Response response = await dio.get("https://fakestoreapi.com/products");
      if (response.statusCode == 200) {
        List<Product> data = (response.data as List)
            .map((item) => Product.fromJson(item))
            .toList();
        return data;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print("Error fetching data: $error");
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, AppRoute.checkout),
        backgroundColor: Colors.purple,
        child: const Icon(Icons.shopping_bag_outlined),
      ),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.purple, Colors.lightBlueAccent])),
        ),
        centerTitle: true,
        title: const Text('Fake Store'),
      ),
      body: Consumer<ProductProvider>(
        builder: (context, provider, child) {
          return FutureBuilder<List<Product>>(
            future: getData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No data available.'));
              } else {
                List<Product> products = snapshot.data! + provider.newProducts;
                return ProductListWidget(products: products);
              }
            },
          );
        },
      ),
    );
  }
}
