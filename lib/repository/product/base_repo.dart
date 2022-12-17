import '../../models/models.dart';

abstract class BaseRepo {
  Stream<List<Product>> getAllProducts();
  Stream<List<Product>> getFilteredProducts(String searchText);
}
