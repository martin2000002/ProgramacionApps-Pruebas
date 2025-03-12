import 'package:flutter/material.dart';
import 'package:flutter_3_riverpod_full/shared/cart_icon.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/index.dart';
import '../../base/index.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterState = ref.watch(filterNotifierProvider);
    final filterOptions = ref.watch(filterOptionsProvider);
    final filteredProducts = ref.watch(filteredProductsProvider);

    final cartProducts =
        ref.watch(cartNotifierProvider); // Leyendo el provider del carrito

    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos en Venta'),
        actions: [
          Switch(
              value: filterState.isSwitchEnabled, //lee el estado actual (watch)
              onChanged: (bool valorSwitch) {
                //se notifica al riverpod la nueva eleccion (read)
                ref
                    .read(filterNotifierProvider.notifier)
                    .toggleSwitch(valorSwitch);
              }),
          CartIcon()
        ],
      ),
      body: Center(
        child: Column(
          children: [
            if (filterState.isSwitchEnabled)
              Text(
                'Selecciona una Opción:',
                style: TextStyle(fontSize: 20),
              ),
            if (filterState.isSwitchEnabled) SizedBox(height: 10),
            if (filterState.isSwitchEnabled)
              DropdownButton<FilterOption>(
                value: filterState
                    .selectedFilter, // Opción seleccionada por default 'Todos'
                onChanged: (nuevaOpcion) {
                  if (nuevaOpcion != null) {
                    ref.read(filterNotifierProvider.notifier).setFilterOption(
                        nuevaOpcion); // Actualiza el estado del Drop
                  }
                },
                items: filterOptions,
              ),
            if (filterState.isSwitchEnabled) SizedBox(height: 10),
            if (filterState.isSwitchEnabled)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: GridView.builder(
                    itemCount: filteredProducts.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: 0.9,
                    ),
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.all(5),
                        color: Colors.blueGrey.withAlpha((0.05 * 255).toInt()),
                        child: Column(
                          children: [
                            Image.asset(filteredProducts[index].image,
                                width: 60, height: 60),
                            Text(filteredProducts[index].title),
                            Text('USD ${filteredProducts[index].price}'),
                            if (cartProducts.contains(filteredProducts[index]))
                              TextButton(
                                onPressed: () {
                                  ref
                                      .read(cartNotifierProvider.notifier)
                                      .removeProduct(filteredProducts[index]);
                                },
                                child: const Text('Eliminar'),
                              ),
                            if (!cartProducts.contains(filteredProducts[index]))
                              TextButton(
                                onPressed: () {
                                  ref
                                      .read(cartNotifierProvider.notifier)
                                      .addProduct(filteredProducts[index]);
                                },
                                child: const Text('Agregar al carro'),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
