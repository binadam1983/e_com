// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'models.dart';

class CartModel extends Equatable {
  final List<Product> products;

  CartModel({this.products = const <Product>[]});

  Map productQuantityMap(products) {
    var result = Map();

    products.forEach((product) {
      if (result.containsKey(product)) {
        result[product] += 1;
      } else {
        result[product] = 1;
      }
    });
    return result;
  }

  double get subTotal =>
      products.fold(0, (total, current) => total += current.price);

  String get subTotalString => subTotal.toStringAsFixed(2);

  double deliveryFee(subTotal) {
    if (subTotal >= 30) {
      return 0.0;
    } else {
      return 10.0;
    }
  }

  double freeDelivery(subTotal) {
    if (subTotal >= 30) {
      return 0.0;
    } else {
      return 30.0 - subTotal;
    }
  }

  String get total => (subTotal + deliveryFee(subTotal)).toStringAsFixed(2);
  String get deliveryFeeString => deliveryFee(subTotal).toStringAsFixed(2);
  String get freeDeliveryString => freeDelivery(subTotal).toStringAsFixed(2);

  @override
  List<Object?> get props => [products];
}
