import '../../data/model/product.dart';

abstract class ProductEvent {

}

class ProductInitializeEvent extends ProductEvent {
  String productId;
  String categoryId;
  ProductInitializeEvent(this.productId,this.categoryId);
}

class ProductAddedToBasket extends ProductEvent {
  Product product;
  ProductAddedToBasket(this.product);
}