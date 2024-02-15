import 'package:clean_archi/core/widgets/info.dart';
import 'package:clean_archi/core/widgets/product_gridview.dart';
import 'package:clean_archi/features/cart/presentation/manager/cubit/cart_cubit.dart';
import 'package:clean_archi/features/cart/presentation/pages/cart_page.dart';
import 'package:clean_archi/features/products/presentation/manager/cubit/products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.db});
  final Database db;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              context.read<CartCubit>().getProducts();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage(db: db),
                ),
              );
            },
            icon: const Icon(Icons.shopping_cart_outlined),
          ),
        ],
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.dehaze_outlined),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<ProductsCubit>().fetchProducts();
        },
        child: HomePageBody(database: db),
      ),
    );
  }
}

class HomePageBody extends StatelessWidget {
  const HomePageBody({super.key, required this.database});
  final Database database;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Info(input1: "Products", input2: "see more"),
            ProductsGridView(
              db: database,
            )
          ],
        ),
      ),
    );
  }
}
