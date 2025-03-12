import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../models/index.dart';
import '../../base/index.dart';
import '../../providers/index.dart';
part 'cart.g.dart';

@riverpod
class CartNotifier extends _$CartNotifier {
  //Cualquier producto
  @override
  Set<Product> build() {
    return const {};
  }

  void addProduct(Product product) {
    if (!state.contains(product)) {
      state = {...state}..add(product);
    }
  }

  void removeProduct(Product product) {
    if (state.contains(product)) {
      state = {...state}..remove(product);
    }
  }

  void clearCart() {
    state = {};
  }
}

@riverpod
Set<Product> filteredCart(ref) {
  final Set<Product> cartProducts = ref.watch(cartNotifierProvider);
  final FilterState filterState = ref.watch(filterNotifierProvider);
  Set<Product> temp = {};
  if (!filterState.isSwitchEnabled) return {};
  switch (filterState.selectedFilter) {
    case FilterOption.menorIgualN:
      for (var p in cartProducts) {
        if (p.price <= filterState.filterValue) {
          temp.add(p);
        }
      }
      return temp;
    case FilterOption.mayorN:
      for (var p in cartProducts) {
        if (p.price > filterState.filterValue) {
          temp.add(p);
        }
      }
      return temp;
    case FilterOption.todos:
      return cartProducts;
  }
}

@riverpod
int cartTotal(ref) {
  final cartProducts = ref.watch(filteredCartProvider);
  int total = 0;
  for (Product product in cartProducts) {
    total += product.price;
  }
  return total;
}
