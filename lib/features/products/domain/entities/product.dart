import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final int id;
  final num price;
  final String image;
  final String name;

  const ProductEntity({
    required this.id,
    required this.price,
    required this.image,
    required this.name,
  });

  @override
  List<Object?> get props => [
        id,
        price,
        image,
        name,
      ];
}
