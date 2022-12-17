// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:e_com/models/models.dart';
import 'package:e_com/repository/product/base_repo.dart';

class ProductRepo extends BaseRepo {
  final FirebaseFirestore _firebaseFirestore;

  ProductRepo({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<Product>> getAllProducts() {
    return _firebaseFirestore.collection('products').snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList());
  }

  @override
  Stream<List<Product>> getFilteredProducts(String searchText) {
    return _firebaseFirestore.collection('products').snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList());
  }
}
