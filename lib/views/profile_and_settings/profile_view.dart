import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samsar/controllers/auth/auth_controller.dart';
import 'package:samsar/constants/color_constants.dart';
import 'package:samsar/widgets/app_button/app_button.dart';
import 'package:samsar/widgets/image_holder/image_holder.dart';


class ProfileView extends StatefulWidget {
  final String name;
  final String userName;
  final String email;
  final String mobileNo;
  final String bio;
  final String imageUrl;
  final String street;
  final String city;
  const ProfileView(
    {
      super.key,
      required this.name,
      required this.userName,
      required this.email,
      required this.mobileNo,
      required this.bio,
      required this.imageUrl,
      required this.street,
      required this.city
    }
  );

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final AuthController authController = Get.find<AuthController>();

  bool isEditing = false;
  File? profileImage;

  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController bioController;
  late TextEditingController streetController;
  late TextEditingController cityController;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    // Initialize controllers with current user data from controller
    final user = authController.user.value;
    usernameController = TextEditingController(text: user?.username ?? widget.userName);
    emailController = TextEditingController(text: user?.email ?? widget.email);
    phoneController = TextEditingController(text: user?.phone ?? widget.mobileNo);
    bioController = TextEditingController(text: user?.bio ?? widget.bio);
    streetController = TextEditingController(text: user?.street ?? widget.street);
    cityController = TextEditingController(text: user?.city ?? widget.city);
  }

  void _updateControllersFromUserData() {
    // Update controllers when user data changes
    final user = authController.user.value;
    if (user != null) {
      usernameController.text = user.username ?? '';
      emailController.text = user.email ?? '';
      phoneController.text = user.phone ?? '';
      bioController.text = user.bio ?? '';
      streetController.text = user.street ?? '';
      cityController.text = user.city ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width;
    final height = screenSize.height;
    
    return Obx(() {
      // Update controllers when user data changes
      final user = authController.user.value;
      if (user != null) {
        // Only update if not currently editing to avoid cursor jumping
        if (!isEditing) {
          _updateControllersFromUserData();
        }
      }
      
      return Scaffold(
      backgroundColor: whiteColor,

      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0,
        title: Text(
          "My Profile",
          style: TextStyle(
            color: blackColor,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Center(
            child: Column(
              children: [

                SizedBox(height: height * 0.04),
                Hero(
                  tag: "image_bridge",
                  child: ImageHolder(
                    isEditable: true,
                    imageUrl: authController.user.value?.profilePicture ?? widget.imageUrl,
                    onImageSelected: (File selectedImage) {
                      setState(() {
                        profileImage = selectedImage;
                      });
                    },
                  )
                ),

                const SizedBox(height: 12),

               
                Text(
                  widget.name,
                  style: TextStyle(
                    color: whiteColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                

                const SizedBox(height: 8),

                Divider(
                  indent: width * 0.18,
                  endIndent: width * 0.18,
                  thickness: 1,
                ),

                const SizedBox(height: 20),

               buildProfileField("Username", usernameController),
                
               
               buildProfileField("Email", emailController),
               
              
               buildProfileField("Phone No", phoneController),
                
               
               buildProfileField("Bio", bioController),
              
                  
              buildProfileField("Street", streetController),
                
             
              buildProfileField("City", cityController),
             
              const SizedBox(height: 22),
                AppButton(
                  widthSize: 0.55,
                  heightSize: 0.06,
                  buttonColor: blueColor,
                  text: isEditing ? "Save" : "Edit",
                  textColor: whiteColor,
                  textSize: 22,
                  onPressed: () async {
                    if (isEditing) {
                      // Save the changes
                      final authController = Get.find<AuthController>();
                      await authController.updateProfile(
                        name: widget.name, // Name is not editable in this view
                        username: usernameController.text,
                        bio: bioController.text,
                        street: streetController.text,
                        city: cityController.text,
                        phone: phoneController.text,
                        profileImage: profileImage,
                      );
                      
                      // Update controllers immediately after successful save
                      _updateControllersFromUserData();
                    }
                    setState(() {
                      isEditing = !isEditing;
                    });
                  },
                )

              ],
            ),
          ),
        ),
      ),
      );
    });
  }

  Widget buildProfileField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: TextStyle(
                color: blueColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              )),
          const SizedBox(height: 4),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: whiteColor,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade100,
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: isEditing
                ? TextField(
                    controller: controller,
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    decoration: const InputDecoration(border: InputBorder.none),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      controller.text,
                      style: TextStyle(
                        color: blackColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}