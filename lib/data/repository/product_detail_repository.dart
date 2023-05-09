import 'package:apple_shop/data/datasource/product_detail_datasource.dart';
import 'package:apple_shop/di/di.dart';
import 'package:dartz/dartz.dart';

import '../../utils/api_exception.dart';
import '../model/product_image.dart';
abstract class IProductDetailRepository {
  Future<Either<String,List<ProductImage>>> getProductImage();
}

class ProductDetailRepository extends IProductDetailRepository {
  final IProductDetailDataSource _dataSource = locator.get();
  @override
  Future<Either<String, List<ProductImage>>> getProductImage() async{
    try {
      final response = await _dataSource.getGallery();
      return right(response);
    } on ApiException catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }

}