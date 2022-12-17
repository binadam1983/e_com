// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:e_com/models/models.dart';

class UserRecordModel extends Equatable {
  final String email;
  Map<String, dynamic>? purchaseHistory;
  List<Product>? wishlist;
  List<Product>? cart;

  UserRecordModel(
      {required this.email, this.purchaseHistory, this.wishlist, this.cart});

  @override
  List<Object?> get props => [email, purchaseHistory, wishlist, cart];

  static final empty = UserRecordModel(email: '');

  UserRecordModel copyWith({
    String? email,
    Map<String, dynamic>? purchaseHistory,
    List<Product>? wishlist,
    List<Product>? cart,
  }) {
    return UserRecordModel(
      email: email ?? this.email,
      purchaseHistory: purchaseHistory ?? this.purchaseHistory,
      wishlist: wishlist ?? this.wishlist,
      cart: cart ?? this.cart,
    );
  }
}
