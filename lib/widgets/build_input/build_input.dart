import 'package:flutter/material.dart';
import 'package:samsar/widgets/label/label.dart';

class BuildInput extends StatelessWidget {
  final String title;
  final String label;
  final TextEditingController textController;
  final String? Function(String?)? validator;
  final int maxLines;
  final TextInputType keyboardType;

  const BuildInput({
    super.key,
    required this.title,
    required this.label,
    required this.textController,
    this.validator,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Label(labelText: title),
        const SizedBox(height: 3),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextFormField(
            controller: textController,
            validator: validator,
            maxLines: maxLines,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              labelText: label,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
