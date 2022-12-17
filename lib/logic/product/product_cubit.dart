import 'package:bloc/bloc.dart';
import 'package:e_com/models/product_model.dart';
import 'package:e_com/repository/product/product_repo.dart';
import 'package:equatable/equatable.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepo _productRepo;

  ProductCubit({required ProductRepo productRepo})
      : _productRepo = productRepo,
        super(ProductLoading()) {
    final state = this.state;
    if (state is ProductLoading) {
      _productRepo
          .getAllProducts()
          .listen((products) => emit(ProductLoaded(products: products)));
    }
  }

  // void updateProducts(List<Product> products) {
  //   final state = this.state;
  //   if (state is ProductLoaded) {
  //     _productRepo
  //         .getAllProducts()
  //         .listen((products) => emit(ProductLoaded(products: products)));
  //   }
  // }
}
