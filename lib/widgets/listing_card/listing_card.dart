import 'package:flutter/material.dart';
import 'package:samsar/constants/color_constants.dart';

// ignore: must_be_immutable
class ListingCard extends StatelessWidget {
  final String title;
  final ImageProvider imageUrl;
  final String description;
  final String subCategory;
  final String listingAction;
  final int price;
  bool isDarkTheme;
  ListingCard(
    {
      super.key,
      required this.title,
      required this.imageUrl,
      required this.description,
      required this.listingAction,
      required this.subCategory,
      required this.price,
      this.isDarkTheme = false,
    }
  );

  @override
  Widget build(BuildContext context) {

    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: double.infinity,
      height: screenHeight * 0.25,
      child: Card(
        color: whiteColor,
        elevation: 4,
        child: Row(
          children: [

            Hero(
              tag: "listing_picture",
              child: imageSection(
                context, 
                screenWidth, 
                screenHeight, 
                imageUrl, 
                subCategory, 
                listingAction
              )
            ),

            Expanded(
              child: detailSection(
                context, 
                screenWidth, 
                screenHeight,
                title, 
                description, 
                price
              ),
            )

           
            
          ],
        ),
      ),
    );
  }

  Widget imageSection(
    BuildContext context, double screenWidth, double screenHeight, ImageProvider imageUrl, String subCategory, String listingAction) {
    return Padding(
      padding:  EdgeInsets.all(screenWidth * 0.03),
      child: Stack(
        children: [
          Container(
            width: screenWidth * 0.37,
            height: screenHeight * 0.2,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(18.0),
            ),
          
          
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(18.0),
              child: Image(
                image: imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),

          Positioned(
            top: screenHeight * 0.17,
            left: screenWidth * 0.15,
            child: Row(
              children: [
                _buildTag(subCategory, Colors.white, Colors.black),
                const SizedBox(width: 4),
                _buildTag(listingAction, Colors.blue, Colors.white),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget detailSection(BuildContext context, double screenWidth, double screenHeight, String title, String description, int price) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(
          color: blackColor,
          fontWeight: FontWeight.bold,
          fontSize: screenWidth * 0.04
        ),),

        const SizedBox(height: 8,),

        Text(description, style: TextStyle(
           fontSize: screenWidth * 0.035,
           color: Colors.black87,
          ),
          softWrap: true,
          maxLines: 2,
          overflow: TextOverflow.visible,
        ),

        const SizedBox(height: 12,),

        infoGrid(screenWidth),

        const SizedBox(height: 14,),

        Text("\$$price", style: TextStyle(
          color: blueColor,
          fontWeight: FontWeight.bold
        ),)
      ],
    );
  }

  Widget _buildTag(String text, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 10, color: textColor),
      ),
    );
  }

  Widget _infoTag(String info, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: blueColor, size: 18,),
        const SizedBox(width: 4,),
        Text(info, style: TextStyle(
          color: blackColor,
          fontWeight: FontWeight.bold
        ),)
      ],
    );
  }

  Widget infoGrid(double screenWidth) {
  final infoItems = [
    _infoTag("Diesel", Icons.gas_meter),
    _infoTag("2019", Icons.calendar_month),
    _infoTag("Manual", Icons.settings),
    _infoTag("1.4L Km", Icons.rocket),
  ];

  // Split the list into chunks of 2
  List<Widget> rows = [];
  for (int i = 0; i < infoItems.length; i += 2) {
    rows.add(
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: infoItems[i]),
            const SizedBox(width: 16),
            Expanded(child: infoItems[i + 1]),
          ],
        ),
      ),
    );
  }

  return Column(children: rows);
}

}