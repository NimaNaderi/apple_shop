import 'package:apple_shop/bloc/basket/basket_event.dart';
import 'package:apple_shop/bloc/basket/basket_state.dart';
import 'package:apple_shop/di/di.dart';
import 'package:bloc/bloc.dart';

import '../../data/repository/basket_repository.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  final IBasketRepository _basketRepository = locator.get();

  BasketBloc() : super(BasketInitState()) {
    on<BasketFetchFromHiveEvent>(
      (event, emit) async {
        var basketItemList = await _basketRepository.getAllBasketItems();
        var basketSummary = await _basketRepository.getFinalBasketPrice();
        emit(BasketDataFetchedState(basketItemList, basketSummary));
      },
    );

    on<BasketItemDeleted>(
      (event, emit) async {
        var basketItemList =
            await _basketRepository.deleteBasketItem(event.basketItem);
        var basketSummary = await _basketRepository.getFinalBasketPrice();
        emit(BasketDataFetchedState(basketItemList, basketSummary));
      },
    );

    on<BasketItemAdded>((event, emit) async {
      _basketRepository.addProductToBasket(event.cartItem);
      add(BasketFetchFromHiveEvent());
      
    });
  }
}
