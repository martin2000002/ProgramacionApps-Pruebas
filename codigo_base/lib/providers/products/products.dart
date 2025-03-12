import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/index.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../providers/index.dart';
import '../../base/index.dart';

part 'products.g.dart';

@riverpod
List<Product> allProducts(ref){
  return [
  Product(
      id: 1,
      title: 'Shorts con Estilo',
      price: 12,
      image: 'assets/products/shorts.png'),
  Product(
      id: 2,
      title: 'Kit de karate',
      price: 34,
      image: 'assets/products/karati.png'),
  Product(
      id: 3,
      title: 'Jeans de Mezclilla',
      price: 54,
      image: 'assets/products/jeans.png'),
  Product(
      id: 4,
      title: 'Mochila Roja',
      price: 14,
      image: 'assets/products/backpack.png'),
  Product(
      id: 5,
      title: 'Tambor y Baquetas',
      price: 29,
      image: 'assets/products/drum.png'),
  Product(
      id: 6,
      title: 'Maleta Azul',
      price: 44,
      image: 'assets/products/suitcase.png'),
  Product(
      id: 7,
      title: 'Patines de Ruedas',
      price: 52,
      image: 'assets/products/skates.png'),
  Product(
      id: 8,
      title: 'Guitarra Eléctrica',
      price: 79,
      image: 'assets/products/guitar.png'),
];
}

@riverpod
List<Product> filteredProducts(ref) {
  final List<Product> allProducts = ref.watch(allProductsProvider);
  final FilterState filterState = ref.watch(filterNotifierProvider);

  if (!filterState.isSwitchEnabled) return [];
  switch (filterState.selectedFilter) {
    case FilterOption.menorIgualN:
    return allProducts.where((p) => p.price <= filterState.filterValue).toList();
    case FilterOption.mayorN:
    return allProducts.where((p) => p.price > filterState.filterValue).toList();
    case FilterOption.todos:
      return allProducts;
  }
}




// //Definimos riverpod provider de forma manual
// final productsProvider = Provider<List<Product>>((ref) {
//   // Provider (No mutable)
//   return allProducts;
// });
// //Provider (no mutable) riverpod reducido con productos menores de 50
// final reducedProductsProvider = Provider<List<Product>>((ref) {
//   return allProducts.where((p) => p.price < 50).toList();
// });




//Parte 2: Codigo para filtrar los productos de home_screen page
//Opcion 1: 
//  a) se puede filtrar usando otro provider (tal como el cart_provider.dart)
//  b) se puede filtrar directamente por aqui creando una clase, como se muestra a continuación

//Clase debe extender de Notifier
//------------------------------------------------------------------
//class FilteredProvider extends Notifier<List<Product>>{
//@override
//List<Product> build() {
//return allProducts; 
//}
// methods to update state
//  List<Product> filteredProducts(String filter) {
//    if (filter == 'Menos de 50') {
    //  return                     // Filtra productos < 50 USD
   // } else if (filter == 'Más de 50') {
     // return                      // Filtra productos >= 50 USD
   // }
   // return allProducts; // Si es "Todos", retorna todos los productos
 // }
//}
//Usar de manera manual el Riverpod "NotifierProvider" (mutable)
//final productosFiltrados = NotifierProvider<FilteredProvider,List<Product>>(FilteredProvider.new);



//Opcion 2: Usar Riverpod Automaticos: ->'package:riverpod_annotation/riverpod_annotation.dart'; 
//Hint: Para eso utilizar el riverpod proporcionado reemplazando lo necesario
//@riverpod
//List<Product> filteredProducts(ref) {
  //final filter =                   // Obtener la seleccion del DropdownMenu  (watch)
   
  //if (filter == 'Menos de 50') {
   // return                           // Filtra productos < 50 USD
 // } else if (filter == 'Más de 50') {
    //return                                  // Filtra productos >= 50 USD
 // }

//  return allProducts; 
//}

