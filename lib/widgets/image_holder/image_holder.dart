import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:samsar/constants/color_constants.dart';


class ImageHolder extends StatefulWidget {
  final String imageUrl;
  final bool isEditable;
  final void Function(File)? onImageSelected;
  const ImageHolder(
    {
      super.key, 
      this.imageUrl = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTGDSuK3gg8gojbS1BjnbA4NLTjMg_hELJbpQ&s", 
      this.isEditable = false,
      this.onImageSelected,
    }
  );

  @override
  State<ImageHolder> createState() => _ImageHolderState();
}

class _ImageHolderState extends State<ImageHolder> {
  File? image;
  final ImagePicker _imagePicker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(source: source);
      if (pickedFile != null) {
        final File selectedImage = File(pickedFile.path);
        setState(() {
          image = selectedImage;
        });

        if (widget.onImageSelected != null) {
          widget.onImageSelected!(selectedImage);
        }
      }
    } catch (e) {
      throw Exception("Failed to pick image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double avatarRadius = screenWidth * 0.15; // 15% of screen width
    final double editButtonSize = avatarRadius * 0.4;

    return Center(
      child: Stack(
        children: [
          // Avatar
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: blueColor,
            ),
            child: CircleAvatar(
              radius: avatarRadius,
              backgroundImage: image != null
                  ? FileImage(image!)
                  :  NetworkImage(
                      widget.imageUrl,
                    ) as ImageProvider,
            ),
          ),

          // Edit Button Positioned on Bottom Right of Avatar
          widget.isEditable ? Positioned(
            bottom: 4,
            right: 8,
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Select Image',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 20),
                          ListTile(
                            leading: const Icon(Icons.camera_alt, color: purpleColor),
                            title: const Text('Take a Picture'),
                            onTap: () {
                              Navigator.pop(context);
                              _pickImage(ImageSource.camera);
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.photo_library, color: purpleColor),
                            title: const Text('Pick from Gallery'),
                            onTap: () {
                              Navigator.pop(context);
                              _pickImage(ImageSource.gallery);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Container(
                height: editButtonSize,
                width: editButtonSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: purpleColor,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: Icon(
                  Icons.edit,
                  size: editButtonSize * 0.6,
                  color: Colors.white,
                ),
              ),
            ),
          ) : SizedBox()
        ],
      ),
    );
  }
}
