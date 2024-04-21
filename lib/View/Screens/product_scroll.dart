import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import '../../Controller/cart_provider.dart';
import '../Widgets/custom_elevatedButton.dart';
import '../Widgets/custom_text.dart';

Widget productScroll(product) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextWidget(
            text: '  Product Name And ID',
          ),
          const SizedBox(height: 10),
          Text(
            "${product.title + " (" + product.id.toString()})",
            style: const TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Divider(),
          const SizedBox(height: 10.0),
          CustomTextWidget(
            text: '  Description',
          ),
          const SizedBox(height: 10.0),
          Text(
            product.description ?? "Product Description Not Found",
            style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w300),
          ),
          const Divider(),
          const SizedBox(height: 10.0),
          CustomTextWidget(
            text: '  Price',
          ),
          const SizedBox(height: 10.0),
          Row(
            children: [
              const Text(
                '  This Product Will Cost :',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                "\$${product.price ?? 0.0}",
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          const Divider(),
          const SizedBox(height: 10.0),
          CustomTextWidget(text: 'Rating'),
          Center(
            child: RatingBar.builder(
              ignoreGestures: true,
              initialRating: product.rating.rate ?? 0.0,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                print(rating);
              },
            ),
          ),
          const Divider(),
          Center(
            child: Consumer<CartProvider>(
              builder: (context, provider, child) {
                final isInCart = provider.isProductInCart(
                    product);
                return MyElevatedButton(
                  onPressed: () {
                    if (isInCart) {
                      provider.removeFromCart(product);
                    } else {
                      provider.addToCart(product);
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('     '),
                      Text(
                        isInCart ? 'Remove from Cart' : 'Add To Cart',
                        style: const TextStyle(color: Colors.white),
                      ),
                      Icon(
                        isInCart ? Icons.delete : Icons.shopping_cart,
                        color: Colors.white,
                      ),
                    ],
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
