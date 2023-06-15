import 'dart:ffi';

import 'package:apple_shop/features/cart/data/datasources/local/basket_datasource_impl.dart';
import 'package:apple_shop/data/model/basket_item.dart';
import 'package:apple_shop/config/di/di.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repositories/basket_repository.dart';
import '../datasources/local/basket_datasource.dart';

class BasketRepository extends IBasketRepository {
  final IBasketDataSource _dataSource = locator.get();

  @override
  Future<Either<String, String>> addProductToBasket(BasketItem item) async {
    try {
      _dataSource.addProduct(item);
      return right('محصول به سبد خرید افزوده شد.');
    } catch (e) {
      return left('خطا در افزودن محصول به سبد خرید !');
    }
  }

  @override
  Future<Either<String, List<BasketItem>>> getAllBasketItems() async {
    try {
      var basketItemList = await _dataSource.getAllBasketItems();
      return right(basketItemList);
    } catch (e) {
      return left('خطا در نمایش محصولات !');
    }
  }

  @override
  Future<List<int>> getFinalBasketPrice() async {
    return await _dataSource.getFinalBasketPrice();
  }

  @override
  Future<Either<String, List<BasketItem>>> deleteBasketItem(BasketItem basketItem) async{
    try {
      await _dataSource.deleteProduct(basketItem);
      var basketItemList = await _dataSource.getAllBasketItems();
      return right(basketItemList);
    } catch (e) {
      return left('خطا در نمایش محصولات !');
    }

  }

  @override
  Future<Either<String, List<BasketItem>>> clearBasket() async{
    try {
      await _dataSource.clearBasket();
      var basketItemList = await _dataSource.getAllBasketItems();
      return right(basketItemList);
    } catch (e) {
      return left('خطا در نمایش محصولات !');
    }
  }
}
