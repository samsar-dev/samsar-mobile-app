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
  final _formKey = GlobalKey<FormState>();
  bool _showValidation = false;

  final List<SelectTypeItem> propertyTypes = [
    SelectTypeItem(title: 'House', icon: Icons.house),
    SelectTypeItem(title: 'Villa', icon: Icons.villa),
    SelectTypeItem(title: 'Apartment', icon: Icons.apartment),
    SelectTypeItem(title: 'Commercial', icon: Icons.restaurant_outlined),
    SelectTypeItem(title: 'Land', icon: Icons.house,),
    SelectTypeItem(title: 'Other', icon: Icons.house),
  ];

  int selectedIndex = -1; // No default selection

  final TextEditingController titleController = TextEditingController();
  final TextEditingController totalAreaController = TextEditingController();
  final TextEditingController yearBuiltController = TextEditingController();
  final TextEditingController bedroomsController = TextEditingController();
  final TextEditingController bathroomsController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController description = TextEditingController();

  @override
  void initState() {
    super.initState();
    
    // Add listeners to trigger rebuild when user types (validation will check field content)
    titleController.addListener(() {
      if (_showValidation) {
        setState(() {}); // Just trigger rebuild, don't reset validation
      }
    });
    
    totalAreaController.addListener(() {
      if (_showValidation) {
        setState(() {}); // Just trigger rebuild, don't reset validation
      }
    });
    
    yearBuiltController.addListener(() {
      if (_showValidation) {
        setState(() {}); // Just trigger rebuild, don't reset validation
      }
    });
    
    bedroomsController.addListener(() {
      if (_showValidation) {
        setState(() {}); // Just trigger rebuild, don't reset validation
      }
    });
    
    bathroomsController.addListener(() {
      if (_showValidation) {
        setState(() {}); // Just trigger rebuild, don't reset validation
      }
    });
    
    priceController.addListener(() {
      if (_showValidation) {
        setState(() {}); // Just trigger rebuild, don't reset validation
      }
    });
    
    description.addListener(() {
      if (_showValidation) {
        setState(() {}); // Just trigger rebuild, don't reset validation
      }
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    totalAreaController.dispose();
    yearBuiltController.dispose();
    bedroomsController.dispose();
    bathroomsController.dispose();
    priceController.dispose();
    locationController.dispose();
    description.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: _formKey,
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
                        print('DEBUG: Property type selected - index: $index, type: ${propertyTypes[index].title}');
                        setState(() {
                          selectedIndex = index;
                          _showValidation = false; // Reset validation when user makes selection
                          print('DEBUG: After setState - selectedIndex: $selectedIndex, _showValidation: $_showValidation');
                        });
                      },
                      hasError: _showValidation && selectedIndex == -1,
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
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Title is required';
                    }
                    return null;
                  },
                  hasError: _showValidation && titleController.text.trim().isEmpty,
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
                  textController: totalAreaController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Total area is required';
                    }
                    return null;
                  },
                  hasError: _showValidation && totalAreaController.text.trim().isEmpty,
                ),

                BuildInput(
                  title: "Year Build", 
                  label: "Enter year of construction",
                  textController: yearBuiltController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Year built is required';
                    }
                    return null;
                  },
                  hasError: _showValidation && yearBuiltController.text.trim().isEmpty,
                ),

                BuildInput(
                  title: "Bedrooms", 
                  label: "Number of bedrooms", 
                  textController: bedroomsController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Number of bedrooms is required';
                    }
                    return null;
                  },
                  hasError: _showValidation && bedroomsController.text.trim().isEmpty,
                ),

                BuildInput(
                  title: "Bathrooms", 
                  label: "Number of bathrooms", 
                  textController: bathroomsController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Number of bathrooms is required';
                    }
                    return null;
                  },
                  hasError: _showValidation && bathroomsController.text.trim().isEmpty,
                ),

                BuildInput(
                 title:  "Price", 
                 label: "Enter price", 
                  textController: priceController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Price is required';
                    }
                    return null;
                  },
                  hasError: _showValidation && priceController.text.trim().isEmpty,
                ),

                BuildInput(
                  title: "Description", 
                  label: "Enter description", 
                  textController: description,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Description is required';
                    }
                    return null;
                  },
                  hasError: _showValidation && description.text.trim().isEmpty,
                ),

                SizedBox(height: screenHeight * 0.02,),

                AppButton(
                  widthSize: 0.5,
                  heightSize: 0.06,
                  buttonColor: blueColor,
                  text: "Add pictures",
                  textColor: whiteColor,
                  onPressed: () {
                    setState(() {
                      _showValidation = true;
                    });
                    
                    bool isValid = _formKey.currentState?.validate() ?? false;
                    bool typeSelected = selectedIndex != -1;
                    print('DEBUG: Validation check - selectedIndex: $selectedIndex, typeSelected: $typeSelected, _showValidation: $_showValidation');
                    
                    if (!typeSelected) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please select a property type'),
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                    
                    if (isValid && typeSelected) {
                      Get.to(AddPictures(isVehicles: false,));
                    }
                  },
                ),

                SizedBox(height: screenHeight * 0.02,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}