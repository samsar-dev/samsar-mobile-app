import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samsar/constants/color_constants.dart';
import 'package:samsar/views/auth/mobile/code_verification/code_verification_view.dart';
import 'package:samsar/widgets/app_button/app_button.dart';
import 'package:samsar/widgets/input_field/input_field.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(

      backgroundColor: blueColor,

      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: screenHeight * 0.2,
                  color: blueColor,
                  child: Center(
                    child: Hero(
                      tag: "auth_title",
                      child: Text("Samsar", style: TextStyle(
                        color: whiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.085
                      ),),
                    ),
                  ),
                ),
                    
                SizedBox(height: screenHeight * 0.03,),

                registerCard(context, screenHeight, screenWidth),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget registerCard(BuildContext context, double screenHeight, double screenWidth) {
    return SizedBox(
      width: screenWidth * 0.95,

      child: Card(
        color: whiteColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              height: screenHeight * 0.08,
              child: Center(
                child: Text("Signup", style: TextStyle(
                  color: blackColor,
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.08
                ),),
              ),
            ),

            inputCard("Name", "Enter your name", _nameController, false, context),
            SizedBox(height: screenHeight * 0.01,),
            inputCard("Email", "Enter your email", _emailController, false, context),
            SizedBox(height: screenHeight * 0.01,),
            inputCard("Username", "Enter your username", _usernameController, false, context),
            SizedBox(height: screenHeight * 0.01,),
            inputCard("Password", "Enter your password", _passwordController, true, context),
            SizedBox(height: screenHeight * 0.01,),
            inputCard("Confirm password", "Enter same password", _confirmPasswordController, true, context),
            SizedBox(height: screenHeight * 0.01,),

            SizedBox(height: screenHeight * 0.004,),

              AppButton(
                widthSize: 0.55,
                heightSize: 0.06,
                buttonColor: blueColor,
                text: "Register",
                textColor: whiteColor,
                onPressed: () {
                  Get.to(CodeVerificationView(), transition: Transition.leftToRight, duration: Duration(milliseconds: 500), curve: Curves.easeIn);
                },
              ),

              SizedBox(height: screenHeight * 0.008,),

               TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text(
                  "Already have an account? Login",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget inputCard(String title, String labelText, TextEditingController controller, bool isPassword, BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
            child: Text(title, style: TextStyle(
              color: blackColor,
              fontWeight: FontWeight.bold,
              fontSize: 22
            ),),
          ),
        ),

        SizedBox(height: MediaQuery.of(context).size.height * 0.005,),

        InputField(
          widthPercentage: 0.8,
          heightPercentage: 0.075,
          labelText: labelText,
          controller: controller,
          isPassword: isPassword,
        ),
      ],
    );
  }
}