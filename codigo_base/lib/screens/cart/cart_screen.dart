import 'package:flutter/material.dart';
//import 'package:flutter_3_riverpod_full/providers/products_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/index.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  bool showCoupon = true;

  @override
  Widget build(BuildContext context) {
//3. Leer metodos del provider
    final filteredProducts = ref.watch(filteredCartProvider);
    final total = ref.watch(cartTotalProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tu Carrito'),
        centerTitle: true,
        // actions: [],
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Column(
                          children: [
                            Column(
            children: filteredProducts.map((product) {
            return Container(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Row(
            children: [
            Image.asset(product.image, width: 60, height: 60),
            const SizedBox(width: 10),
            Text('${product.title}...'),
            const Expanded(child: SizedBox()),
            Text('USD ${product.price}'),
            
            ]
            )
            );
            }).toList(), // output cart products here
            ),
            Text('Precio Total \$ $total'),

              ], // output cart products here
            ),

            // output totals here
          ],
        ),
      ),
    );
  }
}