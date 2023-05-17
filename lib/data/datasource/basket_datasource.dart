import 'package:apple_shop/data/model/basket_item.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class IBasketDataSource {
  Future<void> addProduct(BasketItem item);

  Future<List<BasketItem>> getAllBasketItems();

  Future<int> getFinalBasketPrice();

  Future<void> deleteProduct(BasketItem basketItem);
}

class BasketLocalDataSource extends IBasketDataSource {
  var box = Hive.box<BasketItem>('basketBox');

  @override
  Future<void> addProduct(BasketItem item) async {
    box.add(item);
  }

  @override
  Future<List<BasketItem>> getAllBasketItems() async {
    return box.values.toList();
  }

  @override
  Future<int> getFinalBasketPrice() async {
    var basketList = box.values.toList();
    final finalPrice = basketList.fold(
        0,
        (previousValue, basketItem) =>
            previousValue + basketItem.discountPrice);
    return finalPrice;
  }

  @override
  Future<void> deleteProduct(BasketItem basketItem) async {
    basketItem.delete();
  }
}
