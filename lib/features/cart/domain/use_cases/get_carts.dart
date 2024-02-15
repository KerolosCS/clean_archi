import 'package:clean_archi/core/error/failure.dart';
import 'package:clean_archi/features/cart/domain/repositories/cart_repo.dart';
import 'package:clean_archi/features/products/domain/entities/product.dart';
import 'package:dartz/dartz.dart';

class GetAllCartsUseCase {
  final CartRepo cartRepo;

  GetAllCartsUseCase({required this.cartRepo});
  Future<Either<Failure, List<ProductEntity>>> call() async {
    return await cartRepo.getAllCarts();
  }
}
