import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_network_request/enums/products_enum.dart';
@immutable
class Product{
  final String name;
  final double price;
  
  const Product({required this.name, required this.price});
}

final _products = [
  Product(name: 'laptop', price: 1000 ),
  Product(name: 'tripod stand', price: 600),
  Product(name: "camera", price: 1200),
  Product(name: 'smartphone', price: 800),
];

final productsProvider = Provider<List<Product>>((ref){
  final sortType = ref.watch(productSortTypeProvider);

  switch (sortType){
    case ProductSortType.name:
    return _products.sort((a, b) => a.name.compareTo(b.name)) as List<Product>;
    case ProductSortType.price:
    return _products.sort((a, b) => a.price.compareTo(b.price)) as List<Product>;
  }
});

final productSortTypeProvider = StateProvider<ProductSortType>((ref) => ProductSortType.name);