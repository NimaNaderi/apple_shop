import 'package:apple_shop/data/model/product_image.dart';
import 'package:apple_shop/di/di.dart';
import 'package:dio/dio.dart';

import '../../utils/api_exception.dart';

abstract class IProductDetailDataSource {
  Future<List<ProductImage>> getGallery();
}

class ProductDetailRemoteDataSource extends IProductDetailDataSource {
  final Dio _dio = locator.get();
  @override
  Future<List<ProductImage>> getGallery() async{
    try {
      final Map<String,String> qParams = {'filter': 'product_id=""'};
      var response = await _dio.get('collections/gallery/records');
      return response.data['items']
          .map<ProductImage>(
            (jsonObject) => ProductImage.fromJson(jsonObject),
      )
          .toList();
    } on DioError catch (e) {
      throw ApiException(e.response?.data['message'], e.response?.statusCode);
    } catch (e) {
      throw ApiException('unknown error', 0);
    }
  }

}