import '../../../../../data/model/basket_item.dart';

abstract class IBasketDataSource {
  Future<void> addProduct(BasketItem item);

  Future<List<BasketItem>> getAllBasketItems();

  Future<List<int>> getFinalBasketPrice();

  Future<void> deleteProduct(BasketItem basketItem);

  Future<void> clearBasket();
}