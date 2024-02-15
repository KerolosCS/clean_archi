// ignore_for_file: avoid_print, body_might_complete_normally_catch_error

import 'package:clean_archi/core/sqflite.dart';
import 'package:clean_archi/features/cart/domain/use_cases/add_to_cart_use_case.dart';
import 'package:clean_archi/features/cart/domain/use_cases/delete_from_cart.dart';
import 'package:clean_archi/features/cart/domain/use_cases/get_carts.dart';
import 'package:clean_archi/features/products/data/remote/models/product_model.dart';
import 'package:clean_archi/features/products/domain/entities/product.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit({
    required this.addToCartUseCase,
    required this.deleteFromCartUseCase,
    required this.getAllCarts,
    required this.sq,
  }) : super(CartInitial());
  final SqfliteService sq;
  final AddToCartUseCase addToCartUseCase;
  final DeleteFromCartUseCase deleteFromCartUseCase;
  final GetAllCartsUseCase getAllCarts;

  void createDB() {
    sq.createDatabase();
  }

  void addCart(ProductEntity productModel) async {
    
      addToCartUseCase.call(productModel).then((value) {
        print("Add Row Succesfully");
        emit(AddToCartSuccessfully());
      }).catchError((e) {
        print(e.toString());
      });
  }

  getProducts() async {
    emit(CartItemsLoading());
    List<ProductEntity>? r;
    var res = await getAllCarts.call();
    res.fold(
      (fail) => emit(const GetAllCartsError(error: 'No items in cart')),
      (products) {
        emit(GetAllCartsSuccessfully(products: products));
        r = products;
        print('KEROoooooooooooo :: $products');
      },
    );
    return r;
  }
}
