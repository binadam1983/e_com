// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:e_com/models/models.dart';
import 'package:e_com/repository/category/base_repo.dart';

class CategoryRepo extends BaseRepo {
  final FirebaseFirestore _firebaseFirestore;

  CategoryRepo({
    FirebaseFirestore? firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<Category>> getAllCategories() {
    return _firebaseFirestore.collection('categories').snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => Category.fromSnapshot(doc)).toList());
  }
}
