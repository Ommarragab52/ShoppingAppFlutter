import 'package:dio/dio.dart';
import 'package:flutter_ecommerce_app/core/networking/api_error_model.dart';

class ApiErrorHandler {
  ApiErrorHandler._();
  static ApiErrorModel handleError(dynamic e) {
    if (e is DioException) {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
          return ApiErrorModel(
              message:
                  "Connection timed out. Please check your internet connection.");
        case DioExceptionType.connectionError:
          return ApiErrorModel(
              message:
                  "Connection faild. Please check your internet connection.");

        case DioExceptionType.sendTimeout:
          return ApiErrorModel(
              message: "Send timeout. Please try again later.");

        case DioExceptionType.receiveTimeout:
          return ApiErrorModel(
              message:
                  "Receive timeout. Please check your internet connection.");
        case DioExceptionType.badResponse:
          return _handleBadResponse(e.response);
        case DioExceptionType.cancel:
          return ApiErrorModel(message: "Request cancelled.");

        case DioExceptionType.unknown:
          if (e.error != null &&
              e.error.toString().contains("SocketException")) {
            return ApiErrorModel(
                message: "No internet connection. Please check your network.");
          }
          return ApiErrorModel(
              message: "An unexpected error occurred. Please try again later.");

        default:
          return ApiErrorModel(
              message: "Something went wrong. Please try again later.");
      }
    }
    else if (e is ApiErrorModel) {
      return ApiErrorModel(message: e.message);
    } else if (e is String ||e is String?) {
      return ApiErrorModel(message: e);
    }else {
      return ApiErrorModel(message: 'Unknown error occured');
    }
  }

  static ApiErrorModel _handleBadResponse(Response<dynamic>? errorResponse) {
    if (errorResponse?.data == null) {
      switch (errorResponse?.statusCode) {
        case 400:
          return ApiErrorModel(
              message: 'Bad request. Please check your input.');

        case 401:
          return ApiErrorModel(message: 'Unauthorized. Please log in again.');

        case 403:
          return ApiErrorModel(
              message:
                  'Forbidden. You don\'t have permission to access this resource.');

        case 404:
          return ApiErrorModel(
              message: 'The requested resource was not found.');

        case 500:
          return ApiErrorModel(
              message: 'Internal server error. Please try again later.');

        default:
          return ApiErrorModel(
              message: 'An error occurred. Please try again later.');
      }
    } else {
      return ApiErrorModel(
        message: errorResponse?.data['message'] ?? 'Unknown error occured',
      );
    }
  }
}
