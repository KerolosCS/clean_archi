import 'dart:io';

import 'package:flutter/foundation.dart';

abstract class ShoppingCart {
  static void addBook() {
    int price = int.parse(stdin.readLineSync() ?? '0');
    if (kDebugMode) {
      print(price);
    }
  }
}

void main(List<String> args) {
  ShoppingCart.addBook();
}
