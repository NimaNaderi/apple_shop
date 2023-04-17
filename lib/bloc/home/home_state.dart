import 'package:apple_shop/data/model/banner.dart';
import 'package:dartz/dartz.dart';

abstract class HomeState {}

class HomeInitState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeRequestSuccessState extends HomeState {
  Either<String, List<BannerCampain>> bannerList;
  HomeRequestSuccessState(this.bannerList);
}
