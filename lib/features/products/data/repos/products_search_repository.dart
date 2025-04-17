import 'package:flutter_ecommerce_app/core/networking/api_error_handler.dart';
import 'package:flutter_ecommerce_app/core/networking/api_result.dart';
import 'package:flutter_ecommerce_app/core/networking/api_service.dart';
import 'package:flutter_ecommerce_app/features/products/data/models/products_search_models/products_search_request.dart';
import 'package:flutter_ecommerce_app/features/products/data/models/products_search_models/products_search_response.dart';

class ProductsSearchRepository {
  final ApiService apiService;
  ProductsSearchRepository(this.apiService);

  Future<ApiResult<ProductsSearchResponse>> getProductsByName({
    required ProductsSearchRequest porductsSearchRequest,
    int? page,
  }) async {
    try {
      var response = await apiService.getProductsByName(porductsSearchRequest);
      if (response.status == true) {
        return ApiResult.success(response);
      } else {
        return ApiResult.failure(error: ApiErrorHandler.handleError(response));
      }
    } catch (e) {
      return ApiResult.failure(error: ApiErrorHandler.handleError(e));
    }
  }
}
