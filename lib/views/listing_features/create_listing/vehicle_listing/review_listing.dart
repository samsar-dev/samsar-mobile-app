import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samsar/constants/color_constants.dart';
import 'package:samsar/controllers/listing/create_listing_controller.dart';
import 'package:samsar/controllers/listing/listing_input_controller.dart';
import 'package:samsar/services/listing/create_listing_service.dart';
import 'package:samsar/widgets/animated_input_wrapper/animated_input_wrapper.dart';
import 'package:samsar/widgets/app_button/app_button.dart';

class ReviewListing extends StatelessWidget {
  final bool isVehicle;
  final List<String> imageUrls;
  ReviewListing({super.key, this.isVehicle = true, required this.imageUrls});



  //vehicle controllers

  //real estate controllers

  final TextEditingController titleController = TextEditingController();
  final TextEditingController totalAreaController = TextEditingController();
  final TextEditingController yearBuiltController = TextEditingController();
  final TextEditingController bedroomsController = TextEditingController();
  final TextEditingController bathroomsController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController description = TextEditingController();

  //climate and energy
  final TextEditingController heatingController = TextEditingController();
  final TextEditingController coolingController = TextEditingController();
  final TextEditingController energyFeaturesController = TextEditingController();
  final TextEditingController energyRatingController = TextEditingController();

  //structure and layout
  final TextEditingController basementController = TextEditingController();
  final TextEditingController basementFeaturesController = TextEditingController();
  final TextEditingController atticController = TextEditingController();
  final TextEditingController constructionTypeController = TextEditingController();
  final TextEditingController noOfStoriesController = TextEditingController();

  //interior features
  final TextEditingController floortingTypesController = TextEditingController();
  final TextEditingController windowFeaturesController = TextEditingController();
  final TextEditingController kitchenFeaturesController = TextEditingController();
  final TextEditingController bathroomFeaturesController = TextEditingController();
  final TextEditingController conditionController = TextEditingController();

  //living space details
  final TextEditingController livingAreaController = TextEditingController();
  final TextEditingController halfBathroomsController = TextEditingController();

  //parking and roof
  final TextEditingController roofTypeController = TextEditingController();
  final TextEditingController parkingController = TextEditingController();
  final TextEditingController parkingSpacesController = TextEditingController();

  final ListingInputController _listingInputController = Get.find<ListingInputController>();
  final CreateListingController _createListingController = Get.put(CreateListingController());

  

  @override
  Widget build(BuildContext context) {

    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(

      backgroundColor: whiteColor,

      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [

              AnimatedInputWrapper(
                delayMilliseconds: 0,
                child: ImagePlaceHolder(imageUrls: imageUrls)
              ),

              SizedBox(height: screenHeight * 0.01),

              Obx(
                () {
                  return AnimatedInputWrapper(
                    delayMilliseconds: 100,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: screenWidth * 0.02),
                        child: Text(
                          _listingInputController.title.value,
                          style: TextStyle(
                            color: blackColor,
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth * 0.055,
                          ),
                        ),
                      ),
                    ),
                  );
                }
              ),

              SizedBox(height: screenHeight * 0.02),


              isVehicle ? 
              vehicleWidget(screenHeight, screenWidth) :
              realEstateWidget(screenHeight, screenWidth),

             

               SizedBox(height: screenHeight * 0.008,),

                AppButton(
                  widthSize: 0.65, 
                  heightSize: 0.07, 
                  buttonColor: blueColor,
                  text: "Create", 
                  textColor: whiteColor,
                  onPressed: () {
                    isVehicle ? 
                    _createListingController.createCarListingController(
                      CarModel(
                        title:  _listingInputController.title.value, 
                        description:  _listingInputController.description.value, 
                        price:  _listingInputController.price.value, 
                        mainCategory: "vehicles", 
                        subCategory:  _listingInputController.subCategory.value, 
                        location:  _listingInputController.location.value, 
                        latitude:  _listingInputController.latitude.value, 
                        longitude:  _listingInputController.longitude.value, 
                        condition:  _listingInputController.condition.value, 
                        listingAction: "SALE", 
                        details: Details(
                          vehicleType:  _listingInputController.subCategory.value, 
                          make:  _listingInputController.make.value, 
                          model:  _listingInputController.model.value, 
                          year:  _listingInputController.year.value.toString(), 
                          mileage:  int.tryParse( _listingInputController.mileage.value)!, 
                          previousOwners:  _listingInputController.previousOwners.value, 
                          horsepower:  int.tryParse( _listingInputController.horsepower.value)!, 
                          torque:  int.tryParse( _listingInputController.torque.value)!, 
                          engineSize: int.tryParse( _listingInputController.engineSize.value)!, 
                          engineNumber: _listingInputController.engineNumber.value, 
                          vin: "", 
                          transmissionType: _listingInputController.transmissionType.value, 
                          fuelType: _listingInputController.fuelType.value, 
                          interiorColor: _listingInputController.interiorColor.value, 
                          color: _listingInputController.exteriorColor.value, 
                          registrationStatus: _listingInputController.registrationExpiry.value, 
                          registrationExpiry: _listingInputController.registrationExpiry.value, 
                          serviceHistory: [_listingInputController.serviceHistory.value], 
                          warranty: _listingInputController.warranty.value, 
                          accidentFree: true, 
                          customsCleared: true, 
                          airbags: _listingInputController.noOfAirbags.value, 
                          abs:  _listingInputController.abs.value, 
                          tractionControl:  _listingInputController.tractionControl.value, 
                          laneAssist:  _listingInputController.laneAssist.value, 
                          features:  [], 
                          driveType:  _listingInputController.driveType.value, 
                          bodyType:  _listingInputController.bodyType.value, 
                          wheelSize:  "", 
                          wheelType: "", 
                          fuelEfficiency: "", 
                          emissionClass:  "", 
                          parkingSensor:  "true", 
                          parkingBreak: "true"
                        ), 
                        listingImage:  _listingInputController.listingImage
                      )
                    )
                    : null;
                  },
                ),

              SizedBox(height: screenHeight * 0.05,),
            ],
          ),
        ),
      ),
    );
  }

  Widget infoCard({
  required double screenWidth,
  required double screenHeight,
  required String title,
  required List<Map<String, String>> data,
}) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(vertical: 12),
    padding: EdgeInsets.all(screenWidth * 0.05),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.grey.shade300, width: 1),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.03),
          blurRadius: 12,
          spreadRadius: 2,
          offset: const Offset(0, 4),
        )
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section title
        Text(
          title,
          style: TextStyle(
            fontSize: screenWidth * 0.05,
            fontWeight: FontWeight.w700,
            color: blueColor,
          ),
        ),
        const SizedBox(height: 14),

        // Divider
        Container(
          height: 1,
          color: Colors.grey.shade300,
        ),
        const SizedBox(height: 10),

        // Dynamic rows
        ...data.map((item) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.label_important_outline,
                    size: 18, color: Colors.grey.shade600),
                const SizedBox(width: 8),
                Text(
                  "${item['label']}: ",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                    fontSize: screenWidth * 0.038,
                  ),
                ),
                Expanded(
                  child: Text(
                    item['value']!.isNotEmpty ? item['value']! : "N/A",
                    style: TextStyle(
                      color: Colors.grey.shade800,
                      fontSize: screenWidth * 0.038,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    ),
  );
}

 Widget vehicleWidget(double screenHeight, double screenWidth) {
  return  Obx(
    () {
      return Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Column(
            children: [
              AnimatedInputWrapper(
                delayMilliseconds: 200,
                child: infoCard(
                  screenHeight: screenHeight, 
                  screenWidth: screenWidth , 
                  title:  "Basic info",
                  data: [
                    {"label": "Make", "value": _listingInputController.make.value},
                    {"label": "Model", "value": _listingInputController.model.value},
                    {"label": "Year", "value": "${_listingInputController.year.value}"},
                    {"label": "Price", "value": "\$${_listingInputController.price.value}"},
                    {"label": "Location", "value": _listingInputController.location.value},
                    {"label": "Description", "value": _listingInputController.description.value},
                  ]
                  ),
              ),
      
              SizedBox(height: screenHeight * 0.003,),
      
              AnimatedInputWrapper(
                delayMilliseconds: 300,
                child: infoCard(
                  screenWidth: screenWidth, screenHeight: screenHeight, 
                  title: "Engine and Performance", data: [
                  {"label": "Engine Number", "value": _listingInputController.engineNumber.value},
                  {"label": "Engine Size", "value": "${_listingInputController.engineSize.value} cc"},
                  {"label": "Horsepower", "value": "${_listingInputController.horsepower.value} Hp"},
                  {"label": "Torque", "value": "${_listingInputController.torque.value} NM"},
                  {"label": "Mileage", "value": "${_listingInputController.mileage.value} KMPL"},
                ]),
              ),
      
                SizedBox(height: screenHeight * 0.003,),
      
              AnimatedInputWrapper(
                delayMilliseconds: 400,
                child: infoCard(
                  screenWidth: screenWidth, 
                  screenHeight: screenHeight, 
                  title: "Conditiona and History", data: [
                    {"label": "Service history", "value": _listingInputController.serviceHistory.value},
                    {"label": "Accidental", "value": _listingInputController.accidental.value},
                    {"label": "Warranty", "value": _listingInputController.warranty.value},
                    {"label": "Previous owners", "value": "${_listingInputController.previousOwners.value}"},
                    {"label": "Condition", "value": _listingInputController.condition.value},
                  ]),
              ),
      
                SizedBox(height: screenHeight * 0.003,),
      
                AnimatedInputWrapper(
                delayMilliseconds: 500,
                child: infoCard(
                  screenWidth: screenWidth, 
                  screenHeight: screenHeight, 
                  title: "Legal and Documentation", data: [
                    {"label": "Import status", "value": _listingInputController.importStatus.value},
                    {"label": "Registeration expiry", "value": _listingInputController.registrationExpiry.value},
                  ]),
              ),
      
              SizedBox(height: screenHeight * 0.003,),
      
              AnimatedInputWrapper(
                delayMilliseconds: 600,
                child: infoCard(
                  screenWidth: screenWidth, 
                  screenHeight: screenHeight, 
                  title: "Color and Appearance", data: [
                    {"label": "Exterior color", "value": _listingInputController.exteriorColor.value},
                    {"label": "Interior color", "value": _listingInputController.interiorColor.value},
                  ]),
              ),
            ],
          )
        );
    }
  );
 }

 Widget realEstateWidget(double screenHeight, double screenWidth) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
    child: Column(
      children: [
        // Basic Info
        AnimatedInputWrapper(
          delayMilliseconds: 200,
          child: infoCard(
            screenWidth: screenWidth,
            screenHeight: screenHeight,
            title: "Basic Info",
            data: [
              {"label": "Title", "value": "3 bhk villa"},
              {"label": "Total Area", "value": "4000 sqft"},
              {"label": "Year Built", "value": "2022"},
              {"label": "Bedrooms", "value": "3"},
              {"label": "Bathrooms", "value": "3"},
              {"label": "Price", "value": "\$250000"},
              {"label": "Location", "value": "HOLMS"},
            ],
          ),
        ),

        SizedBox(height: screenHeight * 0.01),

        

        SizedBox(height: screenHeight * 0.01),

        // Climate & Energy
        AnimatedInputWrapper(
          delayMilliseconds: 400,
          child: infoCard(
            screenWidth: screenWidth,
            screenHeight: screenHeight,
            title: "Climate & Energy",
            data: [
              {"label": "Heating", "value": "Central Heating"},
              {"label": "Cooling", "value": "Central air conditioning"},
              {"label": "Energy Features", "value": "Solar panels"},
              {"label": "Energy Rating", "value": "4 stars"},
            ],
          ),
        ),

        SizedBox(height: screenHeight * 0.01),

        // Structure & Layout
        AnimatedInputWrapper(
          delayMilliseconds: 500,
          child: infoCard(
            screenWidth: screenWidth,
            screenHeight: screenHeight,
            title: "Structure & Layout",
            data: [
              {"label": "Basement", "value": "Finished basement"},
              {"label": "Basement Features", "value": "Laundary room"},
              {"label": "Attic", "value": "Finished Attic"},
              {"label": "Construction Type", "value": "Bric"},
              {"label": "Number of Stories", "value": "3"},
            ],
          ),
        ),

        SizedBox(height: screenHeight * 0.01),

        // Interior Features
        AnimatedInputWrapper(
          delayMilliseconds: 600,
          child: infoCard(
            screenWidth: screenWidth,
            screenHeight: screenHeight,
            title: "Interior Features",
            data: [
              {"label": "Flooring Types", "value": "Tile"},
              {"label": "Window Features", "value": "Sky lights"},
              {"label": "Kitchen Features", "value": "Modular kitchen"},
              {"label": "Bathroom Features", "value": "Bathtub"},
              {"label": "Condition", "value": "Needs renovation"},
            ],
          ),
        ),

        SizedBox(height: screenHeight * 0.01),

        // Living Space Details
        AnimatedInputWrapper(
          delayMilliseconds: 700,
          child: infoCard(
            screenWidth: screenWidth,
            screenHeight: screenHeight,
            title: "Living Space Details",
            data: [
              {"label": "Living Area", "value": "3000sqft"},
              {"label": "Half Bathrooms", "value": "0"},
            ],
          ),
        ),

        SizedBox(height: screenHeight * 0.01),

        // Parking & Roof
        AnimatedInputWrapper(
          delayMilliseconds: 800,
          child: infoCard(
            screenWidth: screenWidth,
            screenHeight: screenHeight,
            title: "Parking & Roof",
            data: [
              {"label": "Roof Type", "value": "Flat"},
              {"label": "Parking Type", "value": "Garage"},
              {"label": "Parking Spaces", "value": "3"},
            ],
          ),
        ),
      ],
    ),
  );
}

}



class ImagePlaceHolder extends StatefulWidget {
  final List<String> imageUrls;

  const ImagePlaceHolder({super.key, required this.imageUrls});

  @override
  State<ImagePlaceHolder> createState() => _ImagePlaceHolderState();
}

class _ImagePlaceHolderState extends State<ImagePlaceHolder> {
  int _currentIndex = 0;
  late List<String> _images;

  @override
  void initState() {
    super.initState();
    _images = List<String>.from(widget.imageUrls);
  }

  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
      _currentIndex = _currentIndex.clamp(0, _images.length - 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_images.isEmpty) {
      return Container(
        height: MediaQuery.of(context).size.width * 0.75,
        color: Colors.grey[300],
        alignment: Alignment.center,
        child: const Text("No images selected."),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;
        double height = width * 0.75; // Taller than 16:9 (75% of width)

        return SizedBox(
          width: width,
          height: height,
          child: Stack(
            children: [
              PageView.builder(
                itemCount: _images.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      SizedBox(
                        width: width,
                        height: height,
                        child: Image.network(
                          _images[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                      // ❌ Remove Button
                      Positioned(
                        top: height * 0.15,
                        right: width * 0.08,
                        child: GestureDetector(
                          onTap: () => _removeImage(index),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.6),
                              shape: BoxShape.circle,
                            ),
                            padding: EdgeInsets.all(width * 0.015),
                            child: Icon(Icons.close, color: Colors.white, size: width * 0.05),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),

              // Dot indicator
              Positioned(
                bottom: height * 0.02,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_images.length, (index) {
                    bool isActive = _currentIndex == index;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: EdgeInsets.symmetric(horizontal: width * 0.01),
                      width: isActive ? width * 0.03 : width * 0.02,
                      height: isActive ? width * 0.03 : width * 0.02,
                      decoration: BoxDecoration(
                        color: isActive ? Colors.white : Colors.white54,
                        shape: BoxShape.circle,
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
