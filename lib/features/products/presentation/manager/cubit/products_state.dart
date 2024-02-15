part of 'products_cubit.dart';

sealed class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object> get props => [];
}

final class ProductsInitial extends ProductsState {}

final class GetProductsLoading extends ProductsState {}

final class GetProductsSuccessfully extends ProductsState {
  final List<ProductEntity> products;

  const GetProductsSuccessfully({required this.products});
  @override
  List<Object> get props => [products];
}

final class GetProductsErorr extends ProductsState {
  final String error;

  const GetProductsErorr({required this.error});
  @override
  List<Object> get props => [error];
}
