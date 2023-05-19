import 'package:dartz/dartz.dart';

import '../../data/model/basket_item.dart';

abstract class BasketState {}

class BasketInitState extends BasketState {}

class BasketDataFetchedState extends BasketState {
  Either<String, List<BasketItem>> basketItemList;
  List<int> basketSummary;

  BasketDataFetchedState(this.basketItemList, this.basketSummary);
}
