import 'package:clean_archi/core/error/failure.dart';
import 'package:clean_archi/features/products/domain/entities/product.dart';
import 'package:clean_archi/features/products/domain/repositories/products_repo.dart';
import 'package:dartz/dartz.dart';

class GetProductsUseCase {
  final ProductRepository repo;

  GetProductsUseCase({
    required this.repo,
  });

  Future<Either<Failure, List<ProductEntity>>> call() async {
    return await repo.getProducts();
  }
}
