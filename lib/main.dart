import 'package:fake_store_assignment/Config/app_route.dart';
import 'package:fake_store_assignment/View/Screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Controller/cart_provider.dart';
import 'Controller/product_provider.dart';
import 'Controller/products_controller.dart';
import 'View/Screens/add_product.dart';
import 'View/Screens/checkOut_screen.dart';
import 'View/Screens/home_screen.dart';
import 'View/Screens/product_details_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductSelectionModel()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => ProductProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //initialRoute: AppRoute.home,
      routes: {
        AppRoute.home: (context) => const HomePage(),
        AppRoute.productDetails: (context) => const ProductDetailPage(),
        AppRoute.checkout: (context) => const CheckoutScreen(),
        AppRoute.addProduct: (context) => const AddProductPage(),
      },
      title: 'Fake Store',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
