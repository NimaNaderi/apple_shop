import 'package:apple_shop/data/model/basket_item.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class IBasketDataSource {
  Future<void> addProduct(BasketItem item);
  Future<List<BasketItem>> getAllBasketItems();
}

class BasketLocalDataSource extends IBasketDataSource {
  var box = Hive.box<BasketItem>('basketBox');

  @override
  Future<void> addProduct(BasketItem item) async {
    box.add(item);
  }

  @override
  Future<List<BasketItem>> getAllBasketItems() async{
    return box.values.toList();
  }
}
