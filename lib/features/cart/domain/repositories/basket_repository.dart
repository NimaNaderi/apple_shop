
import 'package:dartz/dartz.dart';

import '../../../../data/model/basket_item.dart';

abstract class IBasketRepository {
  Future<Either<String, String>> addProductToBasket(BasketItem item);

  Future<Either<String, List<BasketItem>>> getAllBasketItems();

  Future<List<int>> getFinalBasketPrice();

  Future<Either<String, List<BasketItem>>> deleteBasketItem(BasketItem basketItem);
  Future<Either<String, List<BasketItem>>> clearBasket();
}
