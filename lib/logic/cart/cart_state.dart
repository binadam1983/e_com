// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'cart_cubit.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartLoading extends CartState {
  @override
  List<Object> get props => [];
}

class CartLoaded extends CartState {
  final CartModel cart;

  CartLoaded({
    required this.cart,
  });

  @override
  List<Object> get props => [cart];
}
