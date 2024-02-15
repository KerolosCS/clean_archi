part of 'cart_cubit.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

final class CartInitial extends CartState {}

final class AddToCartSuccessfully extends CartState {}

final class DeleteFromCartSuccesfully extends CartState {}

final class GetAllCartsSuccessfully extends CartState {
  final List<ProductEntity> products;

  const GetAllCartsSuccessfully({required this.products});
}

final class GetAllCartsError extends CartState {
  final String error;

  const GetAllCartsError({required this.error});
}

final class CartItemsLoading extends CartState {}
