import 'package:apple_shop/data/model/product_image.dart';
import 'package:apple_shop/data/model/product_variant.dart';
import 'package:apple_shop/data/model/variant.dart';
import 'package:apple_shop/data/model/variant_type.dart';
import 'package:apple_shop/di/di.dart';
import 'package:dio/dio.dart';

import '../../utils/api_exception.dart';

abstract class IProductDetailDataSource {
  Future<List<ProductImage>> getGallery();

  Future<List<VariantType>> getVariantTypes();

  Future<List<Variant>> getVariants();

  Future<List<ProductVariant>> getProductVariants();
}

class ProductDetailRemoteDataSource extends IProductDetailDataSource {
  final Dio _dio = locator.get();

  @override
  Future<List<ProductImage>> getGallery() async {
    try {
      final Map<String, String> qParams = {'filter': 'product_id=""'};
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

  @override
  Future<List<VariantType>> getVariantTypes() async {
    try {
      var response = await _dio.get('collections/variants_type/records');
      return response.data['items']
          .map<VariantType>(
            (jsonObject) => VariantType.fromJson(jsonObject),
          )
          .toList();
    } on DioError catch (e) {
      throw ApiException(e.response?.data['message'], e.response?.statusCode);
    } catch (e) {
      throw ApiException('unknown error', 0);
    }
  }

  @override
  Future<List<Variant>> getVariants() async {
    try {
      final Map<String, String> qParams = {'filter': 'product_id="0tc0e5ju89x5ogj"'};

      var response = await _dio.get('collections/variants/records',queryParameters: qParams);
      return response.data['items']
          .map<Variant>(
            (jsonObject) => Variant.fromJson(jsonObject),
          )
          .toList();
    } on DioError catch (e) {
      throw ApiException(e.response?.data['message'], e.response?.statusCode);
    } catch (e) {
      throw ApiException('unknown error', 0);
    }
  }

  @override
  Future<List<ProductVariant>> getProductVariants() async{
    var variantTypeList = await getVariantTypes();
    var variantList = await getVariants();

    List<ProductVariant> productVariantList = [];

    for (var variantType in variantTypeList){
      var finalVariantList = variantList.where((variant) => variant.typeId == variantType.id).toList();

      productVariantList.add(ProductVariant(variantType, finalVariantList));
    }

    return productVariantList;
  }
}
