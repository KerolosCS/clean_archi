import 'package:clean_archi/core/dependency_injection.dart';
import 'package:clean_archi/features/cart/presentation/manager/cubit/cart_cubit.dart';
import 'package:clean_archi/features/products/domain/entities/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({
    super.key,
    required this.data,
    required this.database,
  });
  final ProductEntity data;
  final Database database;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          width: 1,
          color: Colors.black26,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150,
            width: 140,
            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(data.image),
              ),
            ),
          ),
          SizedBox(
            width: 140,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 100,
                      child: Text(
                        data.name,
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: Text(
                        '${data.price} EGP',
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          color: Colors.lightBlueAccent,
                        ),
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    context.read<CartCubit>().addCart(data);
                  },
                  child: const Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.black45,
                    size: 25,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
