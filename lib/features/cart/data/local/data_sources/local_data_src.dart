import 'package:clean_archi/core/sqflite.dart';
import 'package:clean_archi/features/products/data/remote/models/product_model.dart';
import 'package:clean_archi/features/products/domain/entities/product.dart';
import 'package:sqflite/sqflite.dart';

abstract class ProductLocalDataSrc {
  Future<List<ProductModel>> getAllProducts();
  Future<void> addProduct(ProductModel productModel);
  Future<void> deleteProduct(int id);
}

class ProductLocalDataSrcImplement implements ProductLocalDataSrc {
  final SqfliteService service;
  final Database database;

  ProductLocalDataSrcImplement({required this.service, required this.database});
  @override
  Future<void> addProduct(ProductEntity productModel) async {
    return await service.insertToDatabase(
        database: database, productModel: productModel);
  }

  @override
  Future<void> deleteProduct(int id) async {
    return await service.deleteData(id: id, database: database);
  }

  @override
  Future<List<ProductModel>> getAllProducts() async {
    var products = await service.getDataFromDatabase(database);
    var p = await database
        .rawQuery('SELECT * from products')
        .then((value) => {print(value.length)});

    print('KEROO :: $products');
    return products;
  }
}
