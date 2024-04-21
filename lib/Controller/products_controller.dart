import 'package:flutter/material.dart';

class ProductSelectionModel extends ChangeNotifier {
  Set<int> selectedProducts = Set<int>();

  void toggleProductSelection(int index) {
    if (selectedProducts.contains(index)) {
      selectedProducts.remove(index);
    } else {
      selectedProducts.add(index);
    }
    notifyListeners();
  }
}
