// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String name;
  final String imageUrl;

  const Category({
    required this.name,
    required this.imageUrl,
  });

  static Category fromSnapshot(DocumentSnapshot snap) {
    final Category category =
        Category(name: snap['name'], imageUrl: snap['imageUrl']);

    return category;
  }

/*   static List<Category> categories = [
    const Category(name: 'Shampoos', imageUrl: 'assets/images/category0.jpg'),
    const Category(name: 'Clothes', imageUrl: 'assets/images/category1.jpg'),
    const Category(name: 'Perfumes', imageUrl: 'assets/images/category2.jpg'),
    const Category(name: 'Sneakers', imageUrl: 'assets/images/new_arrival3.jpg'),
  ]; */

  @override
  List<Object?> get props => [name, imageUrl];
}
