import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_network_request/enums/products_enum.dart';
import 'package:riverpod_network_request/provider/products_provider.dart';

class Productscreen extends ConsumerWidget {
  const Productscreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          DropdownButton<ProductSortType>(
            value: ref.watch(productSortTypeProvider),
            onChanged: (value) {
              ref.read(productSortTypeProvider.notifier).state =
                  value ?? ProductSortType.name;
            },
            items: [
              DropdownMenuItem(
                value: ProductSortType.name,
                child: Icon(Icons.sort_by_alpha),
              ),
              DropdownMenuItem(
                value: ProductSortType.price,
                child: Icon(Icons.sort),
              ),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ListTile(
            title: Text(product.name),
            subtitle: Text(product.price.toString()),
          );
        },
      ),
    );
  }
}
