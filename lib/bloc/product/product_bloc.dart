import 'package:apple_shop/bloc/product/product_event.dart';
import 'package:apple_shop/bloc/product/product_state.dart';
import 'package:apple_shop/data/repository/product_detail_repository.dart';
import 'package:apple_shop/di/di.dart';
import 'package:bloc/bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final IProductDetailRepository _productDetailRepository = locator.get();
  ProductBloc() : super(ProductInitState()) {
    on<ProductInitializeEvent>(
      (event, emit) async {
        emit(ProductDetailLoadingState());
        var productImages =
            await _productDetailRepository.getProductImage(event.productId);
        var productVariants =
            await _productDetailRepository.getProductVariants(event.productId);
        var productCategory =
            await _productDetailRepository.getProductCategory(event.categoryId);

        var productProperties = await _productDetailRepository
            .getProductProperties(event.productId);

        await Future.delayed(const Duration(seconds: 2), () {});
        emit(ProductDetailResponseState(productImages, productVariants,
            productCategory, productProperties));
      },
    );
  }
}
