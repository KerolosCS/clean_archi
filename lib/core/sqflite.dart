import 'package:clean_archi/features/products/data/remote/models/product_model.dart';
import 'package:clean_archi/features/products/domain/entities/product.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteService {
  static Future<Database> myDB() async {
    return await openDatabase(
      'e_commerce.db',
      version: 1,
      onCreate: (db, version) {
        print("Database created");
        db
            .execute(
          'CREATE TABLE products (id integer primary key, name text, image text ,price integer)',
        )
            .then(
          (value) {
            print("Table created");
          },
        ).catchError((e) {
          print("Error : ${e.toString()}");
        });
      },
      onOpen: (db) {
        print("Database opened");
      },
    );
  }

  Future<Database> createDatabase() async {
    return await openDatabase(
      'e_commerce.db',
      version: 1,
      onCreate: (db, version) {
        print("Database created");
        db
            .execute(
          'CREATE TABLE products (id integer primary key, name text, image text ,price integer)',
        )
            .then(
          (value) {
            print("Table created");
          },
        ).catchError((e) {
          print("Error : ${e.toString()}");
        });
      },
      onOpen: (db) {
        print("Database opened");
        getDataFromDatabase(db);
      },
    );
  }

  Future<void> insertToDatabase({
    required Database database,
    required ProductEntity productModel,
  }) async {
    await database.transaction((txn) {
      return txn.rawInsert(
          'insert into products (name , image , price) values("${productModel.name}","${productModel.image}","${productModel.price}")');
    });
  }

  Future<List<ProductModel>> getDataFromDatabase(Database db) async {
    List<ProductModel> products = [];
    db.rawQuery('SELECT * from products').then((value) {
      for (var element in value) {
        products.add(ProductModel.fromJson(element));
      }
    });
    return products;
  }

  deleteData({required int id, required Database database}) {
    database.rawDelete(
      'DELETE FROM products WHERE id = ?',
      ["$id"],
    ).then((value) {
      getDataFromDatabase(database);
    });
  }
}
