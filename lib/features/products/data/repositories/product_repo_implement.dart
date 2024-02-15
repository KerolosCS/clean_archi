import 'package:clean_archi/core/error/failure.dart';
import 'package:clean_archi/core/exceptions/exceptions.dart';
import 'package:clean_archi/core/network/network_info.dart';
import 'package:clean_archi/features/products/data/remote/data_sources/product_remote_data_src.dart';
import 'package:clean_archi/features/products/domain/entities/product.dart';
import 'package:clean_archi/features/products/domain/repositories/products_repo.dart';
import 'package:dartz/dartz.dart';

class ProductRepoImplement implements ProductRepository {
  final ProductRemoteDataSrc remoteData;
  final NetworkInfoImp network;
  ProductRepoImplement(this.remoteData, this.network);
  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts() async {
    if (await network.isConnected) {
      try {
        final products = await remoteData.getAllProducts();
        return right(products);
      } on ServerException {
        return left(ServerError());
      }
    } else {
      return left(OfflineError());
    }
  }
}
