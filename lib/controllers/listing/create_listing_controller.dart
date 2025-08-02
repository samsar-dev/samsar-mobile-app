import 'package:get/get.dart';
import 'package:samsar/controllers/auth/auth_controller.dart';
import 'package:samsar/models/listing/create_listing/create_car_listing.dart';
import 'package:samsar/services/listing/create_listing_service.dart';
import 'package:samsar/widgets/custom_snackbar/custom_snackbar.dart';
import 'package:samsar/widgets/loading_dialog/loading_dialog.dart';

class CreateListingController extends GetxController {
  final AuthController _authController = Get.find<AuthController>();

  RxBool isCreating = false.obs;

  Future<void> createCarListingController(CarModel carDetails) async {
    try {
      isCreating.value = true;
      loadingDialog('Creating listing...');

      final token = await _authController.getAccessToken();

      final result = await CreateListingService().createCarListingService(token!, carDetails);

      Get.back(); // close loading dialog

      if (result.isSuccess) {
        CreateCarListing response = result.successResponse!;
        showCustomSnackbar("Listing created successfully!", false);
        // You can navigate to detail or home screen if needed here
      } else {
        showCustomSnackbar(
          result.apiError?.errorResponse?.error?.message ??
              result.apiError?.fastifyErrorResponse?.message ??
              "Failed to create listing",
          true,
        );
      }
    } catch (e) {
      Get.back();
      showCustomSnackbar("Unexpected error: $e", true);
    } finally {
      isCreating.value = false;
    }
  }
}
