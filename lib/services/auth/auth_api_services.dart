import 'package:dio/dio.dart';
import 'package:samsar/constants/api_route_constants.dart';
import 'package:samsar/models/api_error.dart';
import 'package:samsar/models/api_response.dart';

class AuthApiServices {
  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        "Content-Type": "application/json",
      },
    ),
  );

  Future<ApiResponse<Map<String, dynamic>>> loginService(String email, String password) async {
    try {
      final response = await _dio.post(
        loginRoute,
        data: {
          "email": email,
          "password": password,
        },
      );


      if (response.statusCode == 200) {
        return ApiResponse.success(response.data as Map<String, dynamic>);
      } else {
        // Handle unexpected status code with error body
        return ApiResponse.failure(ApiError.fromJson(response.data));
      }

    } on DioException catch (dioError) {
      if (dioError.response != null && dioError.response?.data != null) {
        return ApiResponse.failure(ApiError.fromJson(dioError.response!.data));
      }

      // Handle timeout or network errors
      return ApiResponse.failure(
        ApiError(
          fastifyErrorResponse: null,
          errorResponse: null,
        ),
      );
    } catch (e) {
      // Handle unknown parsing or unexpected errors
      return ApiResponse.failure(
        ApiError(
          fastifyErrorResponse: null,
          errorResponse: null,
        ),
      );
    }
  }

  Future<ApiResponse<Map<String, dynamic>>> registerService({
    required String name,
    required String email,
    required String username,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        registerRoute, // make sure this is defined in api_route_constants.dart
        data: {
          "name": name,
          "email": email,
          "username": username,
          "password": password,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse.success(response.data as Map<String, dynamic>);
      } else {
        return ApiResponse.failure(ApiError.fromJson(response.data));
      }

    } on DioException catch (dioError) {
      if (dioError.response != null && dioError.response?.data != null) {
        return ApiResponse.failure(ApiError.fromJson(dioError.response!.data));
      }

      return ApiResponse.failure(ApiError(
        fastifyErrorResponse: null,
        errorResponse: null,
      ));
    } catch (e) {
      return ApiResponse.failure(ApiError(
        fastifyErrorResponse: null,
        errorResponse: null,
      ));
    }
  }

    // Verify Code Service
  Future<ApiResponse<Map<String, dynamic>>> verifyCodeService({
    required String email,
    required String code,
  }) async {
    try {
      final response = await _dio.post(
        verifyCodeRoute, // Make sure this is defined in your api_route_constants.dart
        data: {
          "email": email,
          "code": code,
        },
      );

      if (response.statusCode == 200) {
        return ApiResponse.success(response.data as Map<String, dynamic>);
      } else {
        return ApiResponse.failure(ApiError.fromJson(response.data));
      }
    } on DioException catch (dioError) {
      if (dioError.response != null && dioError.response?.data != null) {
        return ApiResponse.failure(ApiError.fromJson(dioError.response!.data));
      }

      return ApiResponse.failure(ApiError(
        errorResponse: null,
        fastifyErrorResponse: null,
      ));
    } catch (e) {
      return ApiResponse.failure(ApiError(
        errorResponse: null,
        fastifyErrorResponse: null,
      ));
    }
  }
}
