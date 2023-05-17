
import 'package:apple_shop/data/model/basket_item_variant.dart';
import 'package:hive/hive.dart';

part 'basket_item.g.dart';

@HiveType(typeId: 0)
class BasketItem extends HiveObject{
  @HiveField(0)
  String id;
  @HiveField(1)
  String collectionId;
  @HiveField(2)
  String thumbnail;
  @HiveField(3)
  String categoryId;
  @HiveField(4)
  String name;
  @HiveField(5)
  int price;
  @HiveField(6)
  int discountPrice;
  @HiveField(7)
  num? percent;
  @HiveField(8)
  List<BasketItemVariant> basketItemVariantList;

  BasketItem(
      this.id,
      this.collectionId,
      this.thumbnail,
      this.categoryId,
      this.name,
      this.price,
      this.discountPrice,this.basketItemVariantList) {
    percent = ((price - (discountPrice)) / price) * 100;
    // thumbnail =         'http://startflutter.ir/api/files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['thumbnail']}';

  }
}
