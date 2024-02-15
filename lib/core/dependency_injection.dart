import 'package:clean_archi/core/network/network_info.dart';
import 'package:clean_archi/core/sqflite.dart';
import 'package:clean_archi/features/cart/data/local/data_sources/local_data_src.dart';
import 'package:clean_archi/features/cart/data/repositories/cart_repo_imple.dart';
import 'package:clean_archi/features/cart/domain/use_cases/add_to_cart_use_case.dart';
import 'package:clean_archi/features/cart/domain/use_cases/delete_from_cart.dart';
import 'package:clean_archi/features/cart/domain/use_cases/get_carts.dart';
import 'package:clean_archi/features/cart/presentation/manager/cubit/cart_cubit.dart';
import 'package:clean_archi/features/products/data/remote/data_sources/product_remote_data_src.dart';
import 'package:clean_archi/features/products/data/repositories/product_repo_implement.dart';
import 'package:clean_archi/features/products/domain/use_cases/get_products_use_case.dart';
import 'package:clean_archi/features/products/presentation/manager/cubit/products_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sqflite/sqflite.dart';

abstract class ServiceLocator {
  static final sl = GetIt.instance;

  static Future<void> init() async {
    Database db = await SqfliteService.myDB();
//cubit
    sl.registerFactory(() => ProductsCubit(sl<GetProductsUseCase>()));
    sl.registerFactory(() => CartCubit(
          addToCartUseCase: sl<AddToCartUseCase>(),
          deleteFromCartUseCase: sl<DeleteFromCartUseCase>(),
          getAllCarts: sl<GetAllCartsUseCase>(),
          sq: sl<SqfliteService>(),
        ));

    //use cases
    sl.registerLazySingleton(
        () => GetProductsUseCase(repo: sl<ProductRepoImplement>()));
    sl.registerLazySingleton(
        () => AddToCartUseCase(cartRepo: sl<CartRepoImplement>()));
    sl.registerLazySingleton(
        () => DeleteFromCartUseCase(cartRepo: sl<CartRepoImplement>()));
    sl.registerLazySingleton(
        () => GetAllCartsUseCase(cartRepo: sl<CartRepoImplement>()));

    //repos
    sl.registerLazySingleton(() => ProductRepoImplement(
        sl<ProductRemoteDataSrcImplement>(), sl<NetworkInfoImp>()));
    sl.registerLazySingleton(
        () => CartRepoImplement(localData: sl<ProductLocalDataSrcImplement>()));

//datasources
    sl.registerLazySingleton(
        () => ProductRemoteDataSrcImplement(dio: sl<Dio>()));
    sl.registerLazySingleton(() => ProductLocalDataSrcImplement(
        service: sl<SqfliteService>(), database: sl<Database>()));

// dio and network
    sl.registerLazySingleton(
        () => NetworkInfoImp(sl<InternetConnectionChecker>()));
    sl.registerLazySingleton(() => Dio());
    sl.registerLazySingleton(() => InternetConnectionChecker());

    sl.registerLazySingleton(() => SqfliteService());
    sl.registerLazySingleton(() => db);
  }
}
