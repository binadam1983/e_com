// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String name;
  final String category;
  final String imageUrl;
  final double price;
  final bool isBestSelling;
  final bool isNewArrival;
  final bool isOnSale;

  const Product({
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.price,
    required this.isBestSelling,
    required this.isNewArrival,
    required this.isOnSale,
  });

  static Product fromSnapshot(DocumentSnapshot snap) {
    final Product product = Product(
        name: snap['name'],
        category: snap['category'],
        imageUrl: snap['imageUrl'],
        price: snap['price'],
        isBestSelling: snap['isBestSelling'],
        isNewArrival: snap['isNewArrival'],
        isOnSale: snap['isOnSale']);

    return product;
  }

  static List<Product> products = [
    const Product(
        name: 'Shampoo',
        category: 'Shampoos',
        imageUrl: 'assets/images/bestsell0.jpg',
        price: 10.0,
        isBestSelling: true,
        isNewArrival: true,
        isOnSale: true),
    const Product(
        name: 'Summer Shirts',
        category: 'Clothes',
        imageUrl: 'assets/images/bestsell1.jpg',
        price: 10.99,
        isBestSelling: true,
        isNewArrival: true,
        isOnSale: true),
    const Product(
        name: 'Wireless Headphones',
        category: 'Electronics',
        imageUrl: 'assets/images/bestsell3.jpg',
        price: 11.99,
        isBestSelling: true,
        isNewArrival: true,
        isOnSale: true),
    const Product(
        name: 'Apple iPhone 14',
        category: 'Electronics',
        imageUrl: 'assets/images/bestsell4.jpg',
        price: 12.99,
        isBestSelling: true,
        isNewArrival: true,
        isOnSale: true),
    const Product(
        name: 'Wrist Watch',
        category: 'Watches',
        imageUrl: 'assets/images/bestsell5.jpg',
        price: 13.99,
        isBestSelling: true,
        isNewArrival: true,
        isOnSale: false),
    const Product(
        name: 'Nike-Sneakers',
        category: 'Sneakers',
        imageUrl: 'assets/images/new_arrival0.jpg',
        price: 13.99,
        isBestSelling: true,
        isNewArrival: true,
        isOnSale: true),
    const Product(
        name: 'Sneakers-1',
        category: 'Sneakers',
        imageUrl: 'assets/images/new_arrival1.jpg',
        price: 13.99,
        isBestSelling: false,
        isNewArrival: true,
        isOnSale: true),
    const Product(
        name: 'Sneakers-3',
        category: 'Sneakers',
        imageUrl: 'assets/images/new_arrival2.jpg',
        price: 13.99,
        isBestSelling: false,
        isNewArrival: true,
        isOnSale: true),
    const Product(
        name: 'Sneakers-2',
        category: 'Sneakers',
        imageUrl: 'assets/images/new_arrival3.jpg',
        price: 13.99,
        isBestSelling: false,
        isNewArrival: true,
        isOnSale: true),
    const Product(
        name: 'Sneakers-4',
        category: 'Sneakers',
        imageUrl: 'assets/images/new_arrival4.jpg',
        price: 13.99,
        isBestSelling: false,
        isNewArrival: true,
        isOnSale: true),
    const Product(
        name: 'Shampoo-1',
        category: 'Shampoos',
        imageUrl: 'assets/images/shampoo1.jpg',
        price: 13.99,
        isBestSelling: false,
        isNewArrival: false,
        isOnSale: true),
    const Product(
        name: 'Shampoo-2',
        category: 'Shampoos',
        imageUrl: 'assets/images/shampoo2.jpg',
        price: 13.99,
        isBestSelling: false,
        isNewArrival: false,
        isOnSale: true),
    const Product(
        name: 'Shampoo-3',
        category: 'Shampoos',
        imageUrl: 'assets/images/shampoo2.jpg',
        price: 13.99,
        isBestSelling: false,
        isNewArrival: false,
        isOnSale: true),
    const Product(
        name: 'Shampoo-4',
        category: 'Shampoos',
        imageUrl: 'assets/images/shampoo1.jpg',
        price: 13.99,
        isBestSelling: false,
        isNewArrival: false,
        isOnSale: true),
    const Product(
        name: 'perfume-1',
        category: 'perfumes',
        imageUrl: 'assets/images/perfume1.jpg',
        price: 13.99,
        isBestSelling: false,
        isNewArrival: false,
        isOnSale: true),
    const Product(
        name: 'perfume-2',
        category: 'perfumes',
        imageUrl: 'assets/images/perfume2.jpg',
        price: 13.99,
        isBestSelling: false,
        isNewArrival: false,
        isOnSale: false),
  ];

  @override
  List<Object?> get props => [name, category, imageUrl, price, isBestSelling];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'category': category,
      'imageUrl': imageUrl,
      'price': price,
      'isBestSelling': isBestSelling,
      'isNewArrival': isNewArrival,
      'isOnSale': isOnSale,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'] as String,
      category: map['category'] as String,
      imageUrl: map['imageUrl'] as String,
      price: map['price'] as double,
      isBestSelling: map['isBestSelling'] as bool,
      isNewArrival: map['isNewArrival'] as bool,
      isOnSale: map['isOnSale'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);
}
