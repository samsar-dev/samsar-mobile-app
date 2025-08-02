import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samsar/constants/color_constants.dart';
import 'package:samsar/views/listing_features/create_listing/add_pictures/add_pictures.dart';
import 'package:samsar/widgets/app_button/app_button.dart';
import 'package:samsar/widgets/build_input/build_input.dart';
import 'package:samsar/widgets/select_type/select_type.dart';

class RealEstateListing extends StatefulWidget {
  const RealEstateListing({super.key});

  @override
  State<RealEstateListing> createState() => _RealEstateListingState();
}

class _RealEstateListingState extends State<RealEstateListing> {


  final List<SelectTypeItem> propertyTypes = [
    SelectTypeItem(title: 'House', icon: Icons.house),
    SelectTypeItem(title: 'Villa', icon: Icons.villa),
    SelectTypeItem(title: 'Apartment', icon: Icons.apartment),
    SelectTypeItem(title: 'Commercial', icon: Icons.restaurant_outlined),
    SelectTypeItem(title: 'Land', icon: Icons.house,),
    SelectTypeItem(title: 'Other', icon: Icons.house),
  ];

  int selectedIndex = 0;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController totalAreaController = TextEditingController();
  final TextEditingController yearBuiltController = TextEditingController();
  final TextEditingController bedroomsController = TextEditingController();
  final TextEditingController bathroomsController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController description = TextEditingController();


  @override
  Widget build(BuildContext context) {

    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(

      backgroundColor: whiteColor,

      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                    child: Text("Property Type", style: TextStyle(
                      color: blueColor,
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.05
                    ),),
                  ),
                ),
        
                 SizedBox(
                  width: double.infinity,
                  height: screenHeight * 0.25,
                  child: SelectType(
                    items: propertyTypes,
                    selectedIndex: selectedIndex,
                    onItemSelected: (index) {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                  ),
                ),
        
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                    child: Text("Essential Details", style: TextStyle(
                      color: blueColor,
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.05
                    ),),
                  ),
                ),
        
                SizedBox(height: screenHeight * 0.02,),
        
                BuildInput(
                  title: "Title", 
                  label: "Title", 
                  textController: titleController,
                ),
        
                SizedBox(height: screenHeight * 0.01,),
        
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                    child: Text("Property Details", style: TextStyle(
                      color: blueColor,
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.05
                    ),),
                  ),
                ),
        
                SizedBox(height: screenHeight * 0.02,),
        
                BuildInput(
                  title: "Total area", 
                  label: "Enter total area in square meters", 
                  textController: totalAreaController
                ),

                BuildInput(
                  title: "Year Build", 
                  label: "Enter year of construction",
                  textController: yearBuiltController
                ),

                BuildInput(
                  title: "Bedrooms", 
                  label: "Number of bedrooms", 
                  textController: bedroomsController
                ),

                BuildInput(
                  title: "Bathrooms", 
                  label: "Number of bathrooms", 
                  textController: bathroomsController
                ),

                BuildInput(
                 title:  "Price", 
                 label: "Price", 
                  textController: priceController
                ),

                BuildInput(
                  title: "Description", 
                  label: "Description", 
                  textController: description,
                ),

                SizedBox(height: screenHeight * 0.02,),

                AppButton(
                  widthSize: 0.5,
                  heightSize: 0.06,
                  buttonColor: blueColor,
                  text: "Add pictures",
                  textColor: whiteColor,
                  onPressed: () {
                    Get.to(AddPictures(isVehicles: false,));
                  },
                ),

                SizedBox(height: screenHeight * 0.02,),
              ],
            )
          ),
        ),
      ),
    );
  }
}