import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samsar/constants/color_constants.dart';
import 'package:samsar/controllers/auth/auth_controller.dart';
import 'package:samsar/widgets/animated_input_wrapper/animated_input_wrapper.dart';
import 'package:samsar/widgets/user_listing_card.dart/user_listing_card.dart';

class MyListings extends StatelessWidget {
  MyListings({super.key});

  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {

    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: whiteColor,

      appBar: AppBar(
        backgroundColor: whiteColor,
        title: Text("My Listings", style: TextStyle(
          color: blackColor,
          fontWeight: FontWeight.w400
        ),),
      ),

      body: Center(
        child: Obx(
          () {

            if(_authController.isLoading.value) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if(_authController.user.value == null) {
              return Center(
                child: Text("You hasn't listed anything yet"),
              );
            }

            return ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return AnimatedInputWrapper(
                  delayMilliseconds: 100 * index,
                  child: UserListingCard()
                );
              },
            );
          }
        ),
      ),
    );
  }
}