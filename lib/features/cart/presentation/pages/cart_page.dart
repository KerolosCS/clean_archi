import 'package:clean_archi/core/dependency_injection.dart';
import 'package:clean_archi/core/widgets/info.dart';
import 'package:clean_archi/core/widgets/product_widget.dart';
import 'package:clean_archi/features/cart/presentation/manager/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key, required this.db});
  final Database db;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CartPageBody(database: db),
      ),
    );
  }
}

class CartPageBody extends StatelessWidget {
  const CartPageBody({super.key, required this.database});
  final Database database;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Info(input1: "Cart", input2: "see more"),
            ProductsGridViewForCart(
              database: database,
            )
          ],
        ),
      ),
    );
  }
}

class ProductsGridViewForCart extends StatelessWidget {
  const ProductsGridViewForCart({super.key, required this.database});

  final Database database;
  @override
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        if (state is GetAllCartsSuccessfully) {
          return GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            childAspectRatio: 1.15 / 1.5, // width/height
            children: List.generate(
              state.products.length,
              (index) => ProductWidget(
                data: state.products[index],
                database: database,
              ),
            ),
          );
        } else if (state is CartItemsLoading) {
          return Column(
            children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).height * .5 - 75,
              ),
              const CircularProgressIndicator(),
            ],
          );
        } else if (state is GetAllCartsError) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).height * .5 - 75,
              ),
              Text(state.error),
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
