// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../models/models.dart';

abstract class BaseRepo {
  Stream<List<Category>> getAllCategories();
}
