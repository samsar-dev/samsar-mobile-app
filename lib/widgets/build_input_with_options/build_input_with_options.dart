import 'package:flutter/material.dart';
import 'package:samsar/widgets/label/label.dart';

class BuildInputWithOptions extends StatefulWidget {
  final String title;
  final TextEditingController controller;
  final List<String> options;
  final bool hasError;

  const BuildInputWithOptions({
    Key? key,
    required this.title,
    required this.controller,
    required this.options,
    this.hasError = false,
  }) : super(key: key);

  @override
  State<BuildInputWithOptions> createState() => _BuildInputWithOptionsState();
}

class _BuildInputWithOptionsState extends State<BuildInputWithOptions> {
  void _showOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.4,
        minChildSize: 0.2,
        maxChildSize: 0.8,
        builder: (_, scrollController) => Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: Text(
                'Select an option',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: widget.options.length,
                itemBuilder: (_, index) {
                  final option = widget.options[index];
                  return ListTile(
                    title: Text(option),
                    onTap: () {
                      widget.controller.text = option;
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Label(labelText: widget.title),
        const SizedBox(height: 3),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.85,
          child: GestureDetector(
            onTap: _showOptions,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                border: Border.all(
                  color: widget.hasError ? Colors.red : Colors.grey.shade300,
                  width: widget.hasError ? 2.0 : 1.0,
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: widget.hasError ? Colors.red.withOpacity(0.1) : Colors.grey.shade200,
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: widget.controller,
                      readOnly: true,
                      style: const TextStyle(fontSize: 16),
                      decoration: const InputDecoration.collapsed(
                        hintText: "Type or select",
                      ),
                    ),
                  ),
                  const Icon(Icons.arrow_drop_down_rounded, size: 28),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        if (widget.hasError)
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 4),
            child: Text(
              'This field is required',
              style: TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }
}
