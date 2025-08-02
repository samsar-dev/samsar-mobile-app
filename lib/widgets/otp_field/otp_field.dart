import 'package:flutter/material.dart';
import 'package:samsar/constants/color_constants.dart';

class OtpField extends StatefulWidget {
  // final double heightMultiplier;
  final double widthMultiplier;
  final List<TextEditingController> controllers;

  const OtpField({
    super.key,
    // required this.heightMultiplier,
    required this.widthMultiplier,
    required this.controllers
  });

  @override
  State<OtpField> createState() => _OtpFieldState();
}

class _OtpFieldState extends State<OtpField> {
  
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());

  @override
  void dispose() {
    for (var controller in widget.controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * widget.widthMultiplier,
      // height: MediaQuery.of(context).size.height * widget.heightMultiplier,
      color: whiteColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          6,
          (index) => _buildOtpField(context, index),
        ),
      ),
    );
  }

  Widget _buildOtpField(BuildContext context, int index) {
    return SizedBox(
      width: 50,
      child: TextFormField(
        controller: widget.controllers[index],
        focusNode: _focusNodes[index],
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: TextStyle(
          fontSize: 20,
          height: 1.2,
          color: blackColor,
        ),
        onChanged: (value) {
          if (value.isNotEmpty) {
            if (index < widget.controllers.length - 1) {
              FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
            } else {
              _focusNodes[index].unfocus();
            }
          } else if (value.isEmpty && index > 0) {
            FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
          }
          setState(() {}); // trigger color update
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          counterText: "",
          contentPadding: EdgeInsets.symmetric(vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: blueColor, width: 2.0),
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: blackColor),
          ),

          disabledBorder: OutlineInputBorder(
             borderRadius: BorderRadius.circular(18),
             borderSide: BorderSide(color: blackColor),
          )
        ),
      ),
    );
  }
}
