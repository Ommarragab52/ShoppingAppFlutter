import 'package:flutter_ecommerce_app/core/export.dart';
import 'package:flutter_ecommerce_app/core/networking/api_result.dart';
import 'package:flutter_ecommerce_app/features/auth/data/models/login_request.dart';
import 'package:flutter_ecommerce_app/features/auth/data/models/login_response/login_response.dart';
import 'package:flutter_ecommerce_app/features/auth/data/models/register_request.dart';
import 'package:flutter_ecommerce_app/features/auth/data/models/register_response/register_response.dart';

class AuthRepository {
  final ApiService apiService;

  AuthRepository(this.apiService);

  Future<ApiResult<RegisterResponse>> signUp(
      {required RegisterRequest registerRequest}) async {
    try {
      final response = await apiService.signUp(registerRequest);
      if (response.status == true) {
        return ApiResult.success(response);
      } else {
        return ApiResult.failure(
            error: ApiErrorHandler.handleError(response.message));
      }
    } catch (e) {
      return ApiResult.failure(error: ApiErrorHandler.handleError(e));
    }
  }

  Future<ApiResult<LoginResponse>> signIn(
      {required LoginRequest loginRequest}) async {
    try {
      final response = await apiService.signIn(loginRequest);
      if (response.status == true) {
        return ApiResult.success(response);
      } else {
        return ApiResult.failure(
            error: ApiErrorHandler.handleError(response.message));
      }
    } catch (e) {
      return ApiResult.failure(error: ApiErrorHandler.handleError(e));
    }
  }
}
