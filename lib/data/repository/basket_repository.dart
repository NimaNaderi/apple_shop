import 'package:apple_shop/data/datasource/basket_datasource.dart';
import 'package:apple_shop/data/model/basket_item.dart';
import 'package:apple_shop/di/di.dart';
import 'package:dartz/dartz.dart';

abstract class IBasketRepository {
  Future<Either<String, String>> addProductToBasket(BasketItem item);

  Future<Either<String, List<BasketItem>>> getAllBasketItems();

  Future<int> getFinalBasketPrice();

  Future<Either<String, List<BasketItem>>> deleteBasketItem(BasketItem basketItem);
}

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
  Future<int> getFinalBasketPrice() async {
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
}
