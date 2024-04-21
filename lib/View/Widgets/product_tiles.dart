import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Controller/products_controller.dart';
import '../../Model/product_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ProductListWidget extends StatefulWidget {
  List<Product>? products;
  List<Product>? selectedProducts;
  ProductListWidget({Key? key, this.products}) : super(key: key);

  @override
  State<ProductListWidget> createState() => _ProductListWidgetState();
}

class _ProductListWidgetState extends State<ProductListWidget> {
  Set<int> selectedProducts = <int>{};

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/ADD_PRODUCT');
            },
            child: const Text('Add Product'),
          ),
        ),
        Expanded(
          child: MasonryGridView.builder(
            itemCount: widget.products?.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              var product = widget.products?[index];
              return Consumer<ProductSelectionModel>(
                builder: (context, provider, child) {
                  bool isSelected = provider.selectedProducts.contains(index);
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/DETAILS',
                          arguments: product);
                    },
                    child: Card(
                      elevation: 2.0,
                      margin: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    gradient: const LinearGradient(colors: [
                                      Colors.lightBlueAccent,
                                      Colors.purpleAccent
                                    ])),
                                child: Text(
                                  product!.price.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15.0,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  provider.toggleProductSelection(index);
                                },
                                icon: isSelected
                                    ? const Icon(Icons.favorite, color: Colors.red)
                                    : const Icon(Icons.favorite_outline),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10.0),
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                            child: Image.network(
                              '${product.image}',
                              //height: 150,
                              width: double.infinity,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.title ?? "not found",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0,
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  product.description ?? "not found",
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 14.0),
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
            },
            gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
          ),
        ),
      ],
    );
  }
}
