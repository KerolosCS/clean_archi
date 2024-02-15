import 'package:clean_archi/features/cart/domain/repositories/cart_repo.dart';
import 'package:clean_archi/features/products/domain/entities/product.dart';

class AddToCartUseCase {
  final CartRepo cartRepo;

  AddToCartUseCase({required this.cartRepo});

  Future<void> call(ProductEntity product) async {
    await cartRepo.addToCart(product);
  }
}
