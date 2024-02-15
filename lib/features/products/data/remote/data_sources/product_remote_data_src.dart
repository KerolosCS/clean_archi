// ignore_for_file: constant_identifier_names
import 'package:clean_archi/core/exceptions/exceptions.dart';
import 'package:clean_archi/features/products/data/remote/models/product_model.dart';
import 'package:dio/dio.dart';

const BASE_URL = 'https://student.valuxapps.com/api/';
const GET_PRODUCTS_END_POINT = 'products';

abstract class ProductRemoteDataSrc {
  Future<List<ProductModel>> getAllProducts();
}

class ProductRemoteDataSrcImplement implements ProductRemoteDataSrc {
  final Dio dio;

  ProductRemoteDataSrcImplement({required this.dio});
  @override
  Future<List<ProductModel>> getAllProducts() async {
    final response = await dio.get("$BASE_URL$GET_PRODUCTS_END_POINT");
    if (response.statusCode == 200) {
      final listOfMap = response.data['data']['data'] as List;
      List<ProductModel> products = listOfMap
          .map<ProductModel>((json) => ProductModel.fromJson(json))
          .toList();
      return products;
    } else {
      throw ServerException();
    }
  }
}
