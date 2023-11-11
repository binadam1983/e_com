import 'package:bloc/bloc.dart';
import 'package:e_com/models/models.dart';
import 'package:equatable/equatable.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartLoading()) {
    if (state is CartLoading) {
      Future<void>.delayed(const Duration(seconds: 1));
      emit(const CartLoaded(cart: CartModel(products: <Product>[])));
    }
  }

  void addProduct(product) {
    final state = this.state;

    try {
      if (state is CartLoaded) {
        emit(CartLoaded(
            cart: CartModel(
                products: List.from(state.cart.products)..add(product))));
      }
    } catch (_) {}
  }

  void removeProduct(product) {
    final state = this.state;
    // final products = List.from(st)
    try {
      if (state is CartLoaded) {
        emit(CartLoaded(
            cart: CartModel(
                products: List.from(state.cart.products)..remove(product))));
      }
    } catch (_) {}
  }
}
