import 'package:clean_archi/core/error/failure.dart';
import 'package:clean_archi/features/cart/data/local/data_sources/local_data_src.dart';
import 'package:clean_archi/features/cart/domain/repositories/cart_repo.dart';
import 'package:clean_archi/features/products/data/remote/models/product_model.dart';
import 'package:clean_archi/features/products/domain/entities/product.dart';
import 'package:dartz/dartz.dart';

class CartRepoImplement implements CartRepo {
  final ProductLocalDataSrcImplement localData;

  CartRepoImplement({required this.localData});
  @override
  Future<void> addToCart(ProductEntity productModel) async {
    await localData.addProduct(productModel);
  }

  @override
  Future<void> deleteFromCart(int id) async {
    await localData.deleteProduct(id);
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getAllCarts() async {
    List<ProductModel> products = await localData.getAllProducts();
    if (products.isNotEmpty) {
      return Right(products);
    } else {
      return Left(EmptyError());
    }
  }
}
