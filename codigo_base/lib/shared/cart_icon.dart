import 'package:flutter/material.dart';
import 'package:flutter_3_riverpod_full/screens/cart/cart_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/index.dart';

class CartIcon extends ConsumerWidget {
  const CartIcon({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterState = ref.watch(filterNotifierProvider);
    final numeroItems = ref.watch(filteredCartProvider).length;

    return Stack(
      children: [
        IconButton(
          onPressed: () {
            if (filterState.isSwitchEnabled) {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const CartScreen();
              }));
            }
          },
          icon: const Icon(Icons.shopping_bag_outlined),
        ),
        if (filterState.isSwitchEnabled)
          Positioned(
            top: 5,
            left: 5,
            child: Container(
              width: 18,
              height: 18,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blueAccent,
              ),
              child: Text(numeroItems.toString(),
                  style: TextStyle(color: Colors.white)),
            ),
          ),
      ],
    );
  }
}
