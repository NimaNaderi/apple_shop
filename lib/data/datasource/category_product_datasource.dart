import 'package:apple_shop/data/model/product.dart';

abstract class ICategoryProductDataSource {
  Future<List<Product>> getProductsByCategoryId(String categoryId);
}

class CategoryProductRemoteDataSource extends ICategoryProductDataSource {
  @override
  Future<List<Product>> getProductsByCategoryId(String categoryId) async{
    try {
      Map<String, String> queryParams = {'filter': 'popularity="Best Seller"'};
      var response = await _dio.get('collections/products/records',
          queryParameters: queryParams);
      return response.data['items']
          .map<Product>(
            (jsonObject) => Product.fromJson(jsonObject),
          )
          .toList();
    } on DioError catch (e) {
      throw ApiException(e.response?.data['message'], e.response?.statusCode);
    } catch (e) {
      throw ApiException('unknown error', 0);
    }
  }

}