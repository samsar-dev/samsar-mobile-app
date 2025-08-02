import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:samsar/constants/color_constants.dart';
import 'package:samsar/models/auth/login_model.dart';
import 'package:samsar/views/listing_features/my_listings/my_listings.dart';
import 'package:samsar/views/listing_feed/listing_feed_view.dart';
import 'package:samsar/views/profile_and_settings/profile_view.dart';
import 'package:samsar/views/settings/settings.dart';
import 'package:samsar/widgets/app_button/app_button.dart';
import 'package:samsar/widgets/image_holder/image_holder.dart';
import 'package:samsar/controllers/auth/auth_controller.dart';
import 'package:samsar/widgets/listing_card/listing_card.dart';

class ProfileAndSettings extends StatelessWidget {
  ProfileAndSettings({super.key});

  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final AuthController _authController = Get.find<AuthController>();

  Future<User?> _loadUserData() async {
    final raw = await _storage.read(key: "samsar_user_data");
    if (raw == null) return null;

    try {
      final decoded = jsonDecode(raw);
      final data = LoginModel.fromJson(decoded).data;
      return data?.user;
    } catch (e) {
      print("❌ Failed to parse user data: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: FutureBuilder<User?>(
          future: _loadUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            final user = snapshot.data;

            return SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: screenHeight * 0.04),

                    Hero(
                      tag: "image_bridge",
                      child: ImageHolder(
                        imageUrl: user?.profilePicture ??
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTGDSuK3gg8gojbS1BjnbA4NLTjMg_hELJbpQ&s",
                      ),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      user?.name ?? "No name available",
                      style: TextStyle(
                        color: whiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Divider(
                      indent: screenWidth * 0.18,
                      endIndent: screenWidth * 0.18,
                      thickness: 1,
                    ),

                    const SizedBox(height: 20),

                    _buildOptionTile(Icons.person, "View / Edit Profile", () {
                      Get.to(
                        ProfileView(
                          name: user?.name ?? "No name is available",
                          userName: user?.username ?? "No username is available",
                          email: user?.email ?? "No email is available",
                          mobileNo: user?.phone ?? "No phone number is available",
                          bio: user?.bio ?? "No bio is available",
                          street: user?.street ?? "No street is available",
                          city: user?.city ?? "No city is available",
                          imageUrl: user?.profilePicture ??
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTGDSuK3gg8gojbS1BjnbA4NLTjMg_hELJbpQ&s",
                        ),
                      );
                    }),

                    _buildOptionTile(Icons.list_alt, "My Listings", () {
                      Get.to(MyListings());
                    }),

                    _buildOptionTile(Icons.settings, "Settings", () {
                      Get.to(Settings());
                    }),

                    SizedBox(height: screenHeight * 0.08),

                    AppButton(
                      widthSize: 0.65,
                      heightSize: 0.06,
                      buttonColor: Colors.red,
                      text: "Logout",
                      textColor: whiteColor,
                      onPressed: () {
                        _showLogoutDialog(context);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildOptionTile(IconData icon, String title, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          leading: Icon(icon, color: blackColor),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: onTap,
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: IntrinsicHeight(
            child: Column(
              children: [
                const Text(
                  "Are you sure you want to log out?",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () => Get.back(),
                      child: const Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () {
                        _authController.logout();
                      },
                      child: const Text("Ok"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
