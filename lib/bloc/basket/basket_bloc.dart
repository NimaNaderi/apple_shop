import 'package:apple_shop/bloc/basket/basket_event.dart';
import 'package:apple_shop/bloc/basket/basket_state.dart';
import 'package:apple_shop/di/di.dart';
import 'package:bloc/bloc.dart';

import '../../data/repository/basket_repository.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  final IBasketRepository _basketRepository = locator.get();

  BasketBloc() : super(BasketInitState()) {
    on<BasketFetchFromHiveEvent>(
      (event, emit) async{
        var basketItemList = await _basketRepository.getAllBasketItems();
        var finalBasketPrice = await _basketRepository.getFinalBasketPrice();
        emit(BasketDataFetchedState(basketItemList,finalBasketPrice));
      },
    );
  }
}
