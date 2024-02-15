import 'package:clean_archi/core/error/failure.dart';
import 'package:clean_archi/features/products/domain/entities/product.dart';
import 'package:clean_archi/features/products/domain/use_cases/get_products_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit(this.getProducts) : super(ProductsInitial());
  final GetProductsUseCase getProducts;

  void fetchProducts() async {
    emit(GetProductsLoading());
    final productsOrFailure = await getProducts.call();
    productsOrFailure.fold(
      (failure) => emit(GetProductsErorr(error: _mapFailToMsg(failure))),
      (products) => emit(GetProductsSuccessfully(products: products)),
    );
  }

  String _mapFailToMsg(Failure failure) {
    switch (failure.runtimeType) {
      case OfflineError:
        return 'Please check your Internet Connection and try agin';
      case ServerError:
        return 'Please try again later...';

      default:
        return 'Unexpected Error , Please try again .';
    }
  }
}
