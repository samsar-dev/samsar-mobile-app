import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samsar/constants/color_constants.dart';
import 'package:samsar/controllers/auth/auth_controller.dart';
import 'package:samsar/views/auth/mobile/register/register_view.dart';
import 'package:samsar/widgets/app_button/app_button.dart';
import 'package:samsar/widgets/input_field/input_field.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passWordController = TextEditingController();
  final AuthController _authController = Get.find<AuthController>();

  void onSubmit() {
    if(_formKey.currentState!.validate()) {
      _formKey.currentState!.save();


      _authController.login(_emailController.text, _passWordController.text);
      
    }
  }

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
                  height: screenHeight * 0.3,
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
          
                loginCard(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget loginCard(BuildContext context) {

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      width: screenWidth * 0.95,
      height: screenHeight * 0.6,

      child: Card(
        color: whiteColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            SizedBox(
              width: double.infinity,
              height: screenHeight * 0.08,
              child: Center(
                child: Text("Login", style: TextStyle(
                  color: blackColor,
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.08
                ),),
              ),
            ),

            inputCard(
              "Email", 
              "example@email.com", 
              _emailController, 
              false, 
              context,
              (value) {
                if(value == null || value.isEmpty) {
                  return "Please provide the email";
                }

                if(!value.contains("@")) {
                  return "Please provide the valid email";
                }

                return null;
              }
            ),
            SizedBox(height: screenHeight * 0.01,),
            inputCard(
              "Password", 
              "Enter password", 
              _passWordController, 
              true, 
              context,
              (value) {
                if(value == null || value.isEmpty) {
                  return "Please provide the valid password";
                }

                if(value.length < 6) {
                  return "Password cant be lower that 8 characters";
                }

                return null;
              }
            ),

             Container(
                width: screenWidth * 0.9,
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    
                  },
                  child: const Text(
                    "Forgot Password?",
                    style: TextStyle(color: blueColor),
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.004,),

              AppButton(
                widthSize: 0.55,
                heightSize: 0.06,
                buttonColor: blueColor,
                text: "Login",
                textColor: whiteColor,
                onPressed: onSubmit,
              ),

              SizedBox(height: screenHeight * 0.008,),

               TextButton(
                onPressed: () {
                  Get.to(RegisterView(), transition: Transition.downToUp, duration: Duration(milliseconds: 800), curve: Curves.linearToEaseOut);
                },
                child: const Text(
                  "Don't have an account? Sign up",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget inputCard(String title, String labelText, TextEditingController controller, bool isPassword, BuildContext context, String? Function(String?) validator,) {
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
          validator: validator
        ),
      ],
    );
  }
}