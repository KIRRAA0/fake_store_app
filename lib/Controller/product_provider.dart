import 'package:flutter/foundation.dart';

import '../Model/product_model.dart';

class ProductProvider with ChangeNotifier {
   final List<Product> _newProducts = [];

  List<Product> get newProducts => _newProducts;

  void addProduct(Product product) {
    _newProducts.add(product);
    notifyListeners();
  }
}
