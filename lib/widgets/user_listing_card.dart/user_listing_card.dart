import 'package:flutter/material.dart';
import 'package:samsar/constants/color_constants.dart';
import 'package:samsar/widgets/app_button/app_button.dart';

class UserListingCard extends StatelessWidget {
  final bool isFavourite;

  const UserListingCard({
    super.key,
    this.isFavourite = false, // default false
  });

  final String imageUrl = "https://auto.hindustantimes.com/htmobile1/mercedesbenz_e-class-2024/images/exterior_mercedes-benz-e-class-2024_front-left-side_600x400.jpg?imwidth=420";

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: whiteColor,

        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [

              imageSection(screenHeight, screenWidth, imageUrl),

              SizedBox(width: screenWidth * 0.035),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    detailSection("Mercedes e-class", "30000", "HOLMS", "18-04-2025", screenHeight, screenWidth),

                    SizedBox(height: screenHeight * 0.015),

                    // Conditionally render action buttons
                    if (!isFavourite) actionButtons()

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget imageSection(double screenHeight, double screenWidth, String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: Image.network(
        imageUrl,
        width: screenWidth * 0.4,
        height: screenHeight * 0.18,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget actionButtons() {
    return Row(
      children: [
        Expanded(
          child: AppButton(
            widthSize: 1,
            heightSize: 0.06,
            buttonColor: blueColor,
            text: "Edit",
            textColor: whiteColor,
            textSize: 14,
            onPressed: () {
              // Get.to(EditListingView());
            },
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: AppButton(
            widthSize: 1,
            heightSize: 0.06,
            buttonColor: Colors.red,
            text: "Delete",
            textColor: whiteColor,
            textSize: 14,
          ),
        ),
      ],
    );
  }

  Widget detailSection(String title, String price, String location, String date, double screenHeight, double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.04,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: screenHeight * 0.004),
        Text(
          "\$$price",
          style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        SizedBox(height: screenHeight * 0.004),
        locationBadge(Icons.location_pin, location),
        SizedBox(height: screenHeight * 0.004),
        Text(
          date,
          style: TextStyle(color: greyColor, fontSize: 14),
        ),
      ],
    );
  }

  Widget locationBadge(IconData icon, String location) {
    return Row(
      children: [
        Icon(icon, color: greyColor, size: 18),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            location,
            style: TextStyle(color: greyColor, fontSize: 14),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
