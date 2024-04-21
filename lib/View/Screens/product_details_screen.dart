import 'package:fake_store_assignment/View/Screens/product_scroll.dart';
import 'package:flutter/material.dart';

import '../../Model/product_model.dart';
import '../Widgets/button_arrow.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Product product =
        ModalRoute.of(context)!.settings.arguments as Product;

    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    child: Image.network(
                      product.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                buttonArrow(context),
              ],
            ),
            productScroll(product),
          ],
        ),
      ),
    );
  }
}
