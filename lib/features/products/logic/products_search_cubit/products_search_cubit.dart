import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/features/products/data/models/products_search_models/products_search_request.dart';
import 'package:flutter_ecommerce_app/features/products/data/repos/products_search_repository.dart';
import 'package:flutter_ecommerce_app/features/products/logic/products_search_cubit/products_search_state.dart';

class ProductsSearchCubit extends Cubit<ProductsSearchState> {
  final ProductsSearchRepository productsSearchRepository;
  ProductsSearchCubit(this.productsSearchRepository)
      : super(ProductsSearchState.initial);
  TextEditingController searchController = TextEditingController();
  Timer? _timer;
  final Duration _debounceTime = const Duration(milliseconds: 500);

  void onSearch() {
    _timer?.cancel();
    _timer = Timer(_debounceTime, getProductsByName);
  }

  void getProductsByName() async {
    emit(state.copyWith(status: ProductsSearchStateStatus.loading));
    var apiResult = await productsSearchRepository.getProductsByName(
        porductsSearchRequest:
            ProductsSearchRequest(text: searchController.text));
    apiResult.when(
      success: (response) {
        final productsList = response.searchModel?.productsList ?? [];
        emit(
          state.copyWith(
            status: ProductsSearchStateStatus.success,
            productsSearchList: productsList,
          ),
        );
      },
      failure: (error) {
        emit(state.copyWith(
            status: ProductsSearchStateStatus.error,
            errorMessage: error.message ?? 'Unknown error occured'));
      },
    );
  }

  void clearSearch() {
    searchController.clear();
    emit(state.init());
  }
}
