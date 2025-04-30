import 'package:flutter_ecommerce_app/core/export.dart';
import 'package:flutter_ecommerce_app/core/networking/api_result.dart';
import 'package:flutter_ecommerce_app/features/addresses/data/models/address_model.dart';
import 'package:flutter_ecommerce_app/features/addresses/data/models/address_response.dart';
import 'package:flutter_ecommerce_app/features/addresses/data/models/addresses_response/AddressesResponse.dart';

class AddressesRepository {
  final ApiService _apiService;

  AddressesRepository(this._apiService);

  Future<ApiResult<AddressesResponse>> getAddresses() async {
    try {
      final response = await _apiService.getAddresses();
      if (response.status != true) {
        return ApiResult.failure(
            error: ApiErrorHandler.handleError(response.message));
      }
      return ApiResult.success(response);
    } catch (ex) {
      return ApiResult.failure(error: ApiErrorHandler.handleError(ex));
    }
  }

  Future<ApiResult<AddressResponse>> addAddress({
    required AddressModel addressModel,
  }) async {
    try {
      final response = await _apiService.addAddress(addressModel);
      if (response.status != true) {
        return ApiResult.failure(
            error: ApiErrorHandler.handleError(response.message));
      }
      return ApiResult.success(response);
    } catch (ex) {
      return ApiResult.failure(error: ApiErrorHandler.handleError(ex));
    }
  }

  Future<ApiResult<AddressResponse>> updateAddress({
    required int addressId,
    required AddressModel addressModel,
  }) async {
    try {
      final response = await _apiService.updateAddress(addressId, addressModel);
      if (response.status != true) {
        return ApiResult.failure(
            error: ApiErrorHandler.handleError(response.message));
      }
      return ApiResult.success(response);
    } catch (ex) {
      return ApiResult.failure(error: ApiErrorHandler.handleError(ex));
    }
  }

  Future<ApiResult<AddressResponse>> deleteAddress({
    required int addressId,
  }) async {
    try {
      final response = await _apiService.deleteAddress(addressId);
      if (response.status != true) {
        return ApiResult.failure(
            error: ApiErrorHandler.handleError(response.message));
      }
      return ApiResult.success(response);
    } catch (ex) {
      return ApiResult.failure(error: ApiErrorHandler.handleError(ex));
    }
  }
}
