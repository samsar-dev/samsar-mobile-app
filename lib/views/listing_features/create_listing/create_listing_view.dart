import 'package:flutter/material.dart';
import 'package:samsar/constants/color_constants.dart';
import 'package:samsar/views/listing_features/create_listing/real_estate_listing/real_estate_listing.dart';
import 'package:samsar/views/listing_features/create_listing/vehicle_listing/vehicle_listing.dart';

class CreateListingView extends StatefulWidget {
  const CreateListingView({super.key});

  @override
  State<CreateListingView> createState() => _CreateListingViewState();
}

class _CreateListingViewState extends State<CreateListingView> {

  int selectedIndex = 0;
  final List<String> tabs = ['Vehicle', 'Real Estate'];

  @override
  Widget build(BuildContext context) {

    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
       backgroundColor: whiteColor,

       appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0,
        title: Text(
          "Create listing",
          style: TextStyle(
            color: blackColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: SafeArea(
        child: Column(
          children: [

            SizedBox(height: screenHeight * 0.016,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(tabs.length, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ChoiceChip(
                    showCheckmark: false,
                    label: Text(tabs[index]),
                    selected: selectedIndex == index,
                    onSelected: (bool selected) {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    selectedColor: blueColor,
                    labelStyle: TextStyle(
                      color: selectedIndex == index ? Colors.white : Colors.black,
                    ),
                    backgroundColor: Colors.grey[200],
                  ),
                );
              }),
            ),

            SizedBox(height: screenHeight * 0.016,),

            Expanded(
              child: selectedIndex == 0 ? VehicleListing() : RealEstateListing(),
            )

          ],
        ),
      ),
    );
  }
}