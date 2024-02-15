import 'package:clean_archi/features/products/domain/entities/product.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required super.id,
    required super.price,
    required super.image,
    required super.name,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        price: json["price"],
        image: json["image"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "price": price,
        "image": image,
        "name": name,
      };
}
