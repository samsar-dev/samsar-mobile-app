import 'dart:async';
import 'package:flutter/material.dart';
import 'package:samsar/constants/color_constants.dart';
import 'package:samsar/widgets/app_button/app_button.dart';
import 'package:samsar/widgets/otp_field/otp_field.dart';

class CodeVerificationView extends StatelessWidget {
  CodeVerificationView({super.key});

  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(

      backgroundColor: whiteColor,

      appBar: AppBar(
        backgroundColor: whiteColor,
        foregroundColor: blueColor,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.03,),
                Align(
                 alignment: Alignment.centerLeft,
                 child: Padding(
                   padding: const EdgeInsets.only(left: 25),
                   child: Text("Hi Govind👋", style: TextStyle(
                    color: blackColor,
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.08
                   ),),
                 ),
               ),
          
               SizedBox(height: screenHeight * 0.01,),
          
               Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 25),
                 child: Text("verification code has been sent to your email exampleemail@gmail.com", style: TextStyle(
                  color: blackColor,
                  fontSize: screenWidth * 0.04
                 ),),
               ),
          
               OtpBottomSheet(onVerify: (codec) {}, onResend: () {}, otpController: _otpController)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OtpBottomSheet extends StatelessWidget {
  final void Function(String otp) onVerify;
  final VoidCallback onResend;
  final TextEditingController otpController;

  const OtpBottomSheet({
    super.key,
    required this.onVerify,
    required this.onResend,
    required this.otpController
  });

  @override
  Widget build(BuildContext context) {

    final TextEditingController digitOneController = TextEditingController();
    final TextEditingController digitTwoController = TextEditingController();
    final TextEditingController digitThreeController = TextEditingController();
    final TextEditingController digitFourController = TextEditingController();
    final TextEditingController digitFiveController = TextEditingController();
    final TextEditingController digitSixController = TextEditingController();

    List<TextEditingController> otpDigits = [
     digitOneController,
     digitTwoController,
     digitThreeController, 
     digitFourController,
     digitFiveController,
     digitSixController
    ];
    

    return Padding(
      padding: MediaQuery.of(context).viewInsets.add(const EdgeInsets.all(20)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Enter 6-digit OTP",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: whiteColor),
          ),
          const SizedBox(height: 16),
          OtpField(
            // heightMultiplier: 50, 
            widthMultiplier: MediaQuery.of(context).size.width * 0.9,
            controllers: otpDigits
          ),
          const SizedBox(height: 250),

         
          AppButton(
            widthSize: 0.5,
            heightSize: 0.06,
            text: "Verify",
            textColor: whiteColor,
            buttonColor: blueColor,
            onPressed: () {
              final otp = getFullOtp(otpDigits);
             
              if (otp.length == 6) {
                Navigator.pop(context); // Close the bottom sheet
                onVerify(otp);          // Pass the OTP to parent
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Please enter a valid 6-digit OTP")),
                );
              }
            },
          ),

          SizedBox(height: MediaQuery.of(context).size.height * 0.03,),

          ResendCodeSection()
        ],
      ),
    );
  }
}

String getFullOtp(List<TextEditingController> controllers) {
  return controllers.map((controller) => controller.text.trim()).join();
}

class ResendCodeSection extends StatefulWidget {
  const ResendCodeSection({super.key});

  @override
  State<ResendCodeSection> createState() => _ResendCodeSectionState();
}

class _ResendCodeSectionState extends State<ResendCodeSection> {

  static const int _initialSeconds = 120;
  int _remainingSeconds = _initialSeconds;
  late Timer _timer;
  bool _resendEnabled = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {

    _resendEnabled = false;
    _remainingSeconds = _initialSeconds;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if(_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        setState(() {
          _resendEnabled = true;
        });
        _timer.cancel();
      }
    });

  }

  String _formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(1, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return "$minutes:$secs";
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
Widget build(BuildContext context) {
  final double screenWidth = MediaQuery.of(context).size.width;

  return SizedBox(
    width: double.infinity,
    height: MediaQuery.of(context).size.height * 0.05,
    child: Center(
      child: _resendEnabled
          ? TextButton(
              onPressed: () {
                print("Code has been sent again on your email");
                _startTimer();
              },
              child: Text(
                "Resend code",
                style: TextStyle(
                  color: blueColor,
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.05,
                ),
              ),
            )
          : Text(
              _formatTime(_remainingSeconds),
              style: TextStyle(
                color: blueColor,
                fontWeight: FontWeight.bold,
                fontSize: screenWidth * 0.05,
              ),
            ),
    ),
  );
}

}