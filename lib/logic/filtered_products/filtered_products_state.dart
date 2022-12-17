part of 'filtered_products_cubit.dart';

abstract class FilteredProductsState extends Equatable {
  const FilteredProductsState();

  @override
  List<Object> get props => [];
}

class FilteredProductsLoading extends FilteredProductsState {}

class FilteredProductsLoaded extends FilteredProductsState {
  final List<Product> products;

  const FilteredProductsLoaded({
    this.products = const <Product>[],
  });

  @override
  List<Object> get props => [products];
}
