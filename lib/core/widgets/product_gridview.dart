import 'package:clean_archi/core/widgets/product_widget.dart';
import 'package:clean_archi/features/products/presentation/manager/cubit/products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class ProductsGridView extends StatelessWidget {
  const ProductsGridView({super.key, required this.db});
  final Database db;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        if (state is GetProductsSuccessfully) {
          return GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            childAspectRatio: 1.15 / 1.5, // width/height
            children: List.generate(
              state.products.length,
              (index) =>
                  ProductWidget(data: state.products[index], database: db),
            ),
          );
        } else if (state is GetProductsLoading) {
          return Column(
            children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).height * .5 - 75,
              ),
              const CircularProgressIndicator(),
            ],
          );
        } else if (state is GetProductsErorr) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).height * .5 - 75,
              ),
              Text(state.error),
              IconButton(
                onPressed: () {
                  context.read<ProductsCubit>().fetchProducts();
                },
                icon: const Icon(Icons.refresh),
              ),
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
