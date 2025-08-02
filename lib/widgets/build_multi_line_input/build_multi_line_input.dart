import 'package:flutter/material.dart';
import 'package:samsar/constants/color_constants.dart';

class BuildMultilineInput extends StatelessWidget {
  final String title;
  final String label;
  final TextEditingController controller;

  const BuildMultilineInput({
    super.key,
    required this.title,
    required this.label,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                color: blueColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              )),
          const SizedBox(height: 6),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: TextFormField(
              controller: controller,
              minLines: 5,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                hintText: label,
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
