import 'package:apple_shop/features/cart/presentation/bloc/basket_bloc.dart';
import 'package:apple_shop/config/clients/api_client.dart';
import 'package:apple_shop/features/auth/data/datasources/remote/auth_datasource.dart';
import 'package:apple_shop/data/datasource/banner_datasource.dart';
import 'package:apple_shop/features/cart/data/datasources/local/basket_datasource_impl.dart';
import 'package:apple_shop/data/datasource/category_datasource.dart';
import 'package:apple_shop/data/datasource/category_product_datasource.dart';
import 'package:apple_shop/data/datasource/product_datasource.dart';
import 'package:apple_shop/data/datasource/product_detail_datasource.dart';
import 'package:apple_shop/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:apple_shop/data/repository/banner_repository.dart';
import 'package:apple_shop/features/cart/data/repositories/basket_repository_impl.dart';
import 'package:apple_shop/data/repository/category_product_repository.dart';
import 'package:apple_shop/data/repository/category_repository.dart';
import 'package:apple_shop/data/repository/product_detail_repository.dart';
import 'package:apple_shop/data/repository/product_repository.dart';
import 'package:apple_shop/features/auth/domain/usecases/login.dart';
import 'package:apple_shop/features/auth/domain/usecases/register.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../features/auth/data/datasources/remote/auth_datasource_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/cart/data/datasources/local/basket_datasource.dart';
import '../../features/cart/domain/repositories/basket_repository.dart';

final locator = GetIt.instance;

Future<void> getItInit() async {
  // Components
  locator.registerSingleton<Dio>(
      Dio(BaseOptions(baseUrl: 'http://startflutter.ir/api/')));

  locator.registerSingleton<http.Client>(http.Client());

  locator.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());

  locator.registerFactory<ApiClient>(() => HttpClient());

  // DataSources
  locator.registerFactory<IAuthDataSource>(() => AuthenticationRemote());
  locator
      .registerFactory<ICategoryDataSource>(() => CategoryRemoteDataSource());
  locator.registerFactory<IBannerDataSource>(() => BannerRemoteDataSource());
  locator.registerFactory<IProductDataSource>(() => ProductRemoteDataSource());
  locator.registerFactory<IProductDetailDataSource>(
      () => ProductDetailRemoteDataSource());
  locator.registerFactory<ICategoryProductDataSource>(
      () => CategoryProductRemoteDataSource());
  locator.registerFactory<IBasketDataSource>(() => BasketLocalDataSourceImpl());

  // Repositories
  locator.registerFactory<IAuthRepository>(() => AuthenticationRepository());
  locator.registerFactory<ICategoryRepository>(() => CategoryRepository());
  locator.registerFactory<IBannerRepository>(() => BannerRepository());
  locator.registerFactory<IProductRepository>(() => ProductRepository());
  locator.registerFactory<IProductDetailRepository>(
      () => ProductDetailRepository());
  locator.registerFactory<ICategoryProductRepository>(
      () => CategoryProductRepository());
  locator.registerFactory<IBasketRepository>(() => BasketRepository());

  // UseCases
  locator.registerFactory<RegisterUseCase>(() => RegisterUseCase());
  locator.registerFactory<LoginUseCase>(() => LoginUseCase());

  // Blocs
  locator.registerSingleton<BasketBloc>(BasketBloc());
}
