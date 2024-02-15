import 'package:clean_archi/features/cart/domain/repositories/cart_repo.dart';

class DeleteFromCartUseCase {
  final CartRepo cartRepo;

  DeleteFromCartUseCase({required this.cartRepo});

  void call(int id) {
    cartRepo.deleteFromCart(id);
  }
}
