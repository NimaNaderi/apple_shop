import 'package:apple_shop/data/model/banner.dart';
import 'package:apple_shop/di/di.dart';
import 'package:apple_shop/utils/api_exception.dart';
import 'package:dio/dio.dart';

abstract class IBannerDataSource {
  Future<List<Banner>> getBanners();
}

class BannerRemoteDataSource extends IBannerDataSource {
  final Dio _dio = locator.get();
  @override
  Future<List<Banner>> getBanners() async {
    try {
      var banners = await _dio.get('collections/banner/records');

      return banners.data['items']
          .map<Banner>((jsonObject) => Banner.fromJson(jsonObject))
          .toList();
    } on DioError catch (e) {
      throw ApiException(
          e.response?.data['message'], e.response?.data.statusCode);
    } catch (e) {
      throw ApiException('Unknown Error', 0);
    }
  }
}
