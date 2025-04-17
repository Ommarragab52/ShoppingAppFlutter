import 'package:flutter_ecommerce_app/core/export.dart';
import 'package:flutter_ecommerce_app/core/networking/api_result.dart';
import 'package:flutter_ecommerce_app/features/profile/data/models/profile_response.dart';
import 'package:flutter_ecommerce_app/features/profile/data/models/update_profile_request.dart';

class ProfileRepository {
  final ApiService _apiService;

  ProfileRepository(this._apiService);

  Future<ApiResult<ProfileResponse>> getProfile() async {
    try {
      final response = await _apiService.getProfile();
      if (response.status == true) {
        return ApiResult.success(response);
      } else {
        return ApiResult.failure(error: ApiErrorHandler.handleError(response));
      }
    } catch (e) {
      return ApiResult.failure(error: ApiErrorHandler.handleError(e));
    }
  }

  Future<ApiResult<ProfileResponse>> updateProfile(
    UpdateProfileRequest updateProfileRequest,
  ) async {
    try {
      final response = await _apiService.updateProfile(updateProfileRequest);
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
