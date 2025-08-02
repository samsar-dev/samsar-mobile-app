import 'package:get/get.dart';
import 'package:samsar/controllers/auth/auth_controller.dart';
import 'package:samsar/models/settings/get_settings_model.dart';
import 'package:samsar/services/settings/settings_service.dart';

class SettingsController extends GetxController {

  final AuthController _authController = Get.put(AuthController());

  RxBool isLoading = false.obs;

  RxBool allowMessaging = false.obs;
  RxBool listingNotifications = false.obs;
  RxBool messageNotifications = false.obs;
  RxBool loginNotifications = false.obs;
  RxBool newsletterSubscribed = false.obs;
  RxBool showEmail = false.obs;
  RxBool showOnlineStatus = false.obs;
  RxBool showPhoneNumber = false.obs;
  RxBool privateProfile = false.obs;

  Future<void> getSettingsController() async {
    try {

      isLoading.value = true;

      final accessToken = await _authController.getAccessToken();

      final result = await SettingsService().getUserSettingsService(accessToken!);

      if(result.isSuccess && result.successResponse != null) {
        final settings = GetSettingsModel.fromJson(result.successResponse!);

        allowMessaging.value = settings.data?.allowMessaging ?? false;
        listingNotifications.value = settings.data?.listingNotifications ?? false;
        messageNotifications.value = settings.data?.messageNotifications ?? false;
        loginNotifications.value = settings.data?.loginNotifications ?? false;
        newsletterSubscribed.value = settings.data?.newsletterSubscribed ?? false;
        showEmail.value = settings.data?.showEmail ?? false;
        showOnlineStatus.value = settings.data?.showOnlineStatus ?? false;
        showPhoneNumber.value = settings.data?.showPhoneNumber ?? false;
        privateProfile.value = settings.data?.privateProfile ?? false;

        isLoading.value = false;
      }
      
    } catch (e) {
      print("Failed to get notifications and error is: $e");
    }
  }

  Future<void> updateSettingsController() async {
    try {
      isLoading.value = true;

      final accessToken = await _authController.getAccessToken();
      if (accessToken == null) throw Exception("Access token is null");

      final requestBody = {
        "notifications": {
          "listingUpdates": listingNotifications.value,
          "newInboxMessages": messageNotifications.value,
          "loginNotifications": loginNotifications.value,
          "newsletterSubscribed": newsletterSubscribed.value,
        },
        "privacy": {
          "profileVisibility": privateProfile.value ? "private" : "public",
          "allowMessaging": allowMessaging.value,
          "showEmail": showEmail.value,
          "showOnlineStatus": showOnlineStatus.value,
          "showPhone": showPhoneNumber.value,
        }
      };

      final result = await SettingsService().updateUserSettingsService(
        accessToken: accessToken,
        requestBody: requestBody,
      );

      if (result.isSuccess) {
        Get.snackbar("Success", "Settings updated successfully");
      } else {
        print("Update failed: ${result.apiError!.errorResponse!.error!.message}");
        Get.snackbar("Error", "Failed to update settings");
      }
    } catch (e) {
      print("Error updating settings: $e");
      Get.snackbar("Error", "Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }


}