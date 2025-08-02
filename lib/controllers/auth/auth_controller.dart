import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:samsar/models/auth/login_model.dart';
import 'package:samsar/services/auth/auth_api_services.dart';
import 'package:samsar/views/auth/mobile/login/login_view.dart';
import 'package:samsar/views/home/home_view.dart';
import 'package:samsar/widgets/custom_snackbar/custom_snackbar.dart';
import 'package:samsar/widgets/loading_dialog/loading_dialog.dart';


class AuthController extends GetxController {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  final Rxn<User> user = Rxn<User>();
  final RxString accessToken = ''.obs;

  final RxBool isLoading = false.obs;
  final RxBool registerLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _checkLocalLogin();
    _restoreSession();
  }

  Future<void> _restoreSession() async {
    final raw = await _storage.read(key: "samsar_user_data");
    
    if (raw != null) {
      try {
        final json = jsonDecode(raw);
        final loginModel = LoginModel.fromJson(json);

        if (loginModel.data?.user != null && loginModel.data?.tokens?.accessToken != null) {
          user.value = loginModel.data!.user;
          accessToken.value = loginModel.data!.tokens!.accessToken!;
        } 
      } catch (e) {
        throw Exception("Faield to restore session: $e");
      }
    } 
  }

  Future<String?> getAccessToken() async {
    final raw = await _storage.read(key: "samsar_user_data");
    if (raw != null) {
      final parsed = jsonDecode(raw);
      return parsed['data']?['tokens']?['accessToken'];
    }
    return null;
  }



  Future<void> _checkLocalLogin() async {
    // final token = await _storage.read(key: 'samsar_access_token');
    final userJson = await _storage.read(key: 'samsar_user_data');

    if (userJson != null) {
      // accessToken.value = token;
      user.value = User.fromJson(jsonDecode(userJson));
    }
  }



  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;
      loadingDialog('Authenticating...');

      final result = await AuthApiServices().loginService(email, password);

      Get.back(); // Close dialog

      if (result.apiError != null) {
        showCustomSnackbar(
          result.apiError?.errorResponse?.error?.message ?? "Unexpected error occured",
          true
        );
        return;
      }

      if (result.apiError?.fastifyErrorResponse != null) {
        showCustomSnackbar(
          result.apiError?.fastifyErrorResponse?.message ?? "Unexpected error occurred", 
          true,
        );
        return;
      }


      final rawData = result.successResponse;

      if (rawData == null) {
        showCustomSnackbar("Something went wrong. Try again later.", true);
        return;
      }

      final loginModel = LoginModel.fromJson(rawData);
      user.value = loginModel.data?.user;
      accessToken.value = loginModel.data?.tokens?.accessToken ?? "";


      if(user.value == null) {
        isLoading.value = false;

        showCustomSnackbar("User is not present", true);
        return;
      }



      await _storage.write(key: 'samsar_user_data', value: jsonEncode(loginModel.toJson()));


      Get.offAll(() => const HomeView());
      showCustomSnackbar("Login successful", false);
    } catch (e) {
      Get.back();
      showCustomSnackbar("Login failed: $e", true);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String userName,
    required String password,
  }) async {
    try {
      registerLoading.value = true;
      loadingDialog('Registering...');

      final result = await AuthApiServices().registerService(
        name: name,
        email: email,
        username: userName,
        password: password
      );

      Get.back();

      if (result.apiError!.errorResponse != null) {
        showCustomSnackbar(result.apiError!.errorResponse?.error?.message ?? 'Registration failed', true);
        return;
      }

      showCustomSnackbar('Verification code sent to your email.', false);
    } catch (e) {
      Get.back();
      showCustomSnackbar('Registration failed: $e', true);
    } finally {
      registerLoading.value = false;
    }
  }

  Future<void> verifyCode(String email, String code) async {
    try {
      isLoading.value = true;
      loadingDialog('Verifying code...');

      final result = await AuthApiServices().verifyCodeService(email: email, code: code);

      Get.back();

      if (result.apiError!.errorResponse != null) {
        showCustomSnackbar(result.apiError!.errorResponse?.error?.message ?? 'Verification failed', true);
        return;
      }

      showCustomSnackbar('Email verified successfully. Please log in.', false);
      await Future.delayed(const Duration(seconds: 1));
      Get.offAll(() => LoginView());
    } catch (e) {
      Get.back();
      showCustomSnackbar('Verification failed: $e', true);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await _storage.deleteAll();
    user.value = null;
    accessToken.value = '';
    Get.offAll(() => LoginView());
    showCustomSnackbar('Logged out successfully', true);
  }
}
