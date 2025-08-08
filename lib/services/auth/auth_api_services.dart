import 'dart:io';

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
        "Accept-Encoding": "gzip, deflate",
      },
      responseType: ResponseType.json,
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
      // Handle specific HTTP error codes like 401, 403
      if (dioError.response != null) {
        final statusCode = dioError.response?.statusCode;
        if (statusCode == 401 || statusCode == 403) {
          return ApiResponse.failure(ApiError.fromMessage('Invalid credentials. Please try again.'));
        }

        // Try to parse a structured error from the response body
        if (dioError.response?.data != null) {
          return ApiResponse.failure(ApiError.fromJson(dioError.response!.data));
        }
      }

      // Handle timeout, network, or other unexpected Dio errors
      return ApiResponse.failure(ApiError.fromMessage('Network error. Please check your connection.'));
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

  Future<ApiResponse<Map<String, dynamic>>> updateProfileService({
    required String token,
    required String name,
    required String username,
    required String bio,
    required String street,
    required String city,
    String? phone,
    File? profileImage,
  }) async {
    try {
      print('Creating multipart form data...');
      final formData = FormData.fromMap({
        'name': name,
        'username': username,
        'bio': bio,
        'street': street,
        'city': city,
        'phone': phone ?? '',
      });

      if (profileImage != null) {
        print('Adding profile image: ${profileImage.path}');
        print('Image file exists: ${await File(profileImage.path).exists()}');
        print('Image file size: ${await File(profileImage.path).length()} bytes');
        
        formData.files.add(MapEntry(
        'profilePicture',
        await MultipartFile.fromFile(
          profileImage.path,
          filename: 'profile_${DateTime.now().millisecondsSinceEpoch}.jpg',
        ),
      ));
      } else {
        print('No profile image provided');
      }

      print('Form data created with fields: ${formData.fields}');
      print('Form data files: ${formData.files.length}');

      final response = await _dio.put(
        updateProfileRoute,
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      print('Response status: ${response.statusCode}');
      print('Response data: ${response.data}');
      print('Response data type: ${response.data.runtimeType}');
      print('Response headers: ${response.headers}');
      print('Full response: ${response.toString()}');
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data != null) {
          return ApiResponse.success(response.data as Map<String, dynamic>);
        } else {
          // Success but no data returned
          return ApiResponse.success({'message': 'Profile updated successfully'});
        }
      } else {
        print('Profile update failed with status: ${response.statusCode}');
        if (response.data != null) {
          final error = ApiError.fromJson(response.data);
          return ApiResponse.failure(error);
        } else {
          return ApiResponse.failure(ApiError.fromMessage('Profile update failed with status ${response.statusCode}'));
        }
      }
    } on DioException catch (dioError) {
      print('DioException: ${dioError.message}');
      print('Status code: ${dioError.response?.statusCode}');
      print('Response data: ${dioError.response?.data}');
      
      if (dioError.response != null && dioError.response?.data != null) {
        return ApiResponse.failure(ApiError.fromJson(dioError.response!.data));
      }

      return ApiResponse.failure(ApiError.fromMessage('Failed to update profile. Please try again.'));
    } catch (e) {
      print('Profile update service error: $e');
      return ApiResponse.failure(ApiError.fromMessage('An unexpected error occurred: $e'));
    }
  }

  Future<ApiResponse<Map<String, dynamic>>> getUserProfile(String token) async {
    try {
      print('🔍 getUserProfile: Making request to $getUserProfileRoute');
      print('🔑 getUserProfile: Using token ${token.substring(0, 20)}...');
      
      final response = await _dio.get(
        getUserProfileRoute,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Accept-Encoding': 'gzip, deflate, br',
          },
          responseType: ResponseType.json,
        ),
      );

      print('📥 getUserProfile: Response status ${response.statusCode}');
      print('📥 getUserProfile: Response headers ${response.headers}');
      print('📥 getUserProfile: Response data ${response.data}');
      print('📥 getUserProfile: Response data type ${response.data.runtimeType}');
      
      if (response.statusCode == 200) {
        if (response.data != null) {
          return ApiResponse.success(response.data as Map<String, dynamic>);
        } else {
          print('❌ getUserProfile: Response data is null despite 200 status');
          return ApiResponse.failure(ApiError.fromMessage('Server returned empty response'));
        }
      } else {
        return ApiResponse.failure(ApiError.fromJson(response.data));
      }
    } on DioException catch (dioError) {
      print('❌ getUserProfile: DioException ${dioError.message}');
      print('❌ getUserProfile: Status code ${dioError.response?.statusCode}');
      print('❌ getUserProfile: Response data ${dioError.response?.data}');
      
      if (dioError.response != null && dioError.response?.data != null) {
        return ApiResponse.failure(ApiError.fromJson(dioError.response!.data));
      }
      return ApiResponse.failure(ApiError.fromMessage('Failed to fetch user profile'));
    } catch (e) {
      return ApiResponse.failure(ApiError.fromMessage('An unexpected error occurred: $e'));
    }
  }
}
