import 'package:clean_archi/core/bloc_op.dart';
import 'package:clean_archi/core/dependency_injection.dart';
import 'package:clean_archi/core/sqflite.dart';
import 'package:clean_archi/features/cart/presentation/manager/cubit/cart_cubit.dart';
import 'package:clean_archi/features/products/presentation/manager/cubit/products_cubit.dart';
import 'package:clean_archi/features/products/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  var db = await SqfliteService.myDB();
  Bloc.observer = MyBlocObserver();
  await ServiceLocator.init();

  runApp(MyApp(
    db: db,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.db,
  });
  final Database db;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              ServiceLocator.sl<ProductsCubit>()..fetchProducts(),
        ),
        BlocProvider(
          create: (context) => ServiceLocator.sl<CartCubit>()..getProducts(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(db: db),
      ),
    );
  }
}
