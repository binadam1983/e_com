import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/product_model.dart';
import '../../repository/product/product_repo.dart';

part 'filtered_products_state.dart';

class FilteredProductsCubit extends Cubit<FilteredProductsState> {
  final ProductRepo _productRepo;

  FilteredProductsCubit({required ProductRepo productRepo})
      : _productRepo = productRepo,
        super(FilteredProductsLoading()) {
    final state = this.state;
    if (state is FilteredProductsLoading) {
      Future.delayed(const Duration(seconds: 1));
      emit(const FilteredProductsLoaded());

      // updateFilteredProducts();
    }
  }

  void updateFilteredProducts(String searchText) {
    final state = this.state;
    if (state is FilteredProductsLoaded) {
      _productRepo.getFilteredProducts(searchText).listen(
          (products) => emit(FilteredProductsLoaded(products: products)));
    }
  }
}
