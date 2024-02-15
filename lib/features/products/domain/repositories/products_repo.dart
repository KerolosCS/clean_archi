import 'package:clean_archi/core/error/failure.dart';
import 'package:clean_archi/features/products/domain/entities/product.dart';
import 'package:dartz/dartz.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<ProductEntity>>> getProducts();
}
