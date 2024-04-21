import '../Model/product_model.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final List<Product> cart = [];
  double? _totalPrice;

  void addToCart(Product product) {
    cart.add(product);
    notifyListeners();
  }

  void removeFromCart(Product product) {
    cart.remove(product);
    notifyListeners();
  }
  void clearCart() {
    cart.clear();
    notifyListeners();
  }
  bool isProductInCart(Product product) {
    return cart.contains(product);
  }

  String getTotalPrice() {
    _totalPrice = 0.0;
    for (var element in cart) {
      _totalPrice = (_totalPrice ?? 0.0) + (element.price);
    }
    return _totalPrice?.toString() ??
        "0.0";
  }
}
