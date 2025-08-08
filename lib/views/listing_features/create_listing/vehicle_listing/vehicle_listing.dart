import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samsar/constants/color_constants.dart';
import 'package:samsar/controllers/features/location_controller.dart';
import 'package:samsar/controllers/listing/listing_input_controller.dart';
import 'package:samsar/views/listing_features/create_listing/add_pictures/add_pictures.dart';
import 'package:samsar/widgets/app_button/app_button.dart';
import 'package:samsar/widgets/build_input/build_input.dart';
import 'package:samsar/widgets/build_input_with_options/build_input_with_options.dart';
import 'package:samsar/widgets/build_multi_line_input/build_multi_line_input.dart';
import 'package:samsar/widgets/select_type/select_type.dart';



class VehicleListing extends StatefulWidget {
  const VehicleListing({super.key});

  @override
  State<VehicleListing> createState() => _VehicleListingState();
}

class _VehicleListingState extends State<VehicleListing> {

  final ListingInputController _listingInputController = Get.put(ListingInputController());
  // final LocationController _locationController = Get.find<LocationController>();
  final LocationController _locationController = Get.put(LocationController());
  final _formKey = GlobalKey<FormState>();
  bool _showValidation = false;

  @override
  void initState() {
    super.initState();
    
    locationController = TextEditingController(text: _locationController.address.value);
    
    // Add listeners to trigger rebuild when user types (validation will check field content)
    titleController.addListener(() {
      if (_showValidation) {
        setState(() {}); // Just trigger rebuild, don't reset validation
      }
    });
    
    priceController.addListener(() {
      if (_showValidation) {
        setState(() {}); // Just trigger rebuild, don't reset validation
      }
    });
    
    locationController.addListener(() {
      if (_showValidation) {
        setState(() {}); // Just trigger rebuild, don't reset validation
      }
    });
    
    descriptionController.addListener(() {
      if (_showValidation) {
        setState(() {}); // Just trigger rebuild, don't reset validation
      }
    });
    
    makeController.addListener(() {
      final make = makeController.text.trim();
      setState(() {
        modelOptions = makeToModels[make] ?? ["Custom"];
      });
      
      if (_showValidation) {
        setState(() {}); // Just trigger rebuild, don't reset validation
      }
    });
    
    modelController.addListener(() {
      if (_showValidation) {
        setState(() {}); // Just trigger rebuild, don't reset validation
      }
    });
    
    yearController.addListener(() {
      if (_showValidation) {
        setState(() {}); // Just trigger rebuild, don't reset validation
      }
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    priceController.dispose();
    locationController.dispose();
    descriptionController.dispose();
    makeController.dispose();
    modelController.dispose();
    yearController.dispose();
    super.dispose();
  }

   final List<SelectTypeItem> vehicleTypes = [
    SelectTypeItem(title: 'Car', icon: Icons.directions_car),
    SelectTypeItem(title: 'Truck', icon: Icons.fire_truck),
    SelectTypeItem(title: 'Motorcycle', icon: Icons.motorcycle),
    SelectTypeItem(title: 'Rv', icon: Icons.directions_car),
    SelectTypeItem(title: 'Bus', icon: Icons.bus_alert,),
    SelectTypeItem(title: 'Van', icon: Icons.directions_car),
    SelectTypeItem(title: 'Tractor', icon: Icons.directions_car),
    SelectTypeItem(title: 'Others', icon: Icons.directions_car),
    // SelectTypeItem(title: 'Hyundai', icon: Icons.directions_car),
  ];

  List<String> modelOptions = [];

  final List<String> options = [
    "Audi",
    "BMW",
    "Chervolet",
    "Fisker",
    "Ford",
    "Honda",
    "Hyundai",
    "Kia",
    "Lexus",
    "Lucid",
    "Mercedes-Benz",
    "Nissan",
    "Polester",
    "Porsche",
    "Rivian",
    "Subaru",
    "Tesla",
    "Toyota",
    "Volkswagen",
    "Volvo",
    "Others"
  ];

  final Map<String, List<String>> makeToModels = {
    "Audi": [
      "A3", "A4", "A6", "A7", "A8", "Custom", "Q3", "Q4 e-tron", "Q5", "Q7", "Q8", "Q8 e-tron", "R8", "TT", "e-tron", "e-tron GT"
    ],
    "BMW": [
      "3 Series", "5 Series", "7 Series", "Custom", "M3", "M4", "M5", "X3", "X4", "X5", "X6", "X7", "i3", "i4", "i7", "i8", "iX", "iX1", "iX3"
    ],
    "Chevrolet": [
      "Blazer", "Bolt EV", "Camaro", "Colorado", "Corvette", "Custom", "Equinox", "Malibu", "Silverado", "Suburban", "Tahoe", "Traverse", "Trax"
    ],
    "Fisker": [
      "Custom", "Ocean", "Pear"
    ],
    "Ford": [
      "Bronco", "Bronco Sport", "Custom", "E-Transit", "EcoSport", "Edge", "Escape", "Expedition", "Explorer", "F-150", "F-150 Lightning",
      "Mustang", "Mustang GT", "Mustang Mach-E", "Ranger"
    ],
    "Honda": [
      "Accord", "Civic", "Civic Type R", "CR-V", "Custom", "Fit", "HR-V", "Insight", "Odyssey", "Passport", "Pilot", "Pilot Elite", "Ridgeline"
    ],
    "Hyundai": [
      "Custom", "Elantra", "Elantra N", "Ioniq", "Ioniq 5", "Ioniq 6", "Ioniq 7", "Kona", "Kona Electric", "Nexo",
      "Palisade", "Santa Fe", "Sonata", "Tucson", "Veloster", "Venue"
    ],
    "Kia": [
      "Carnival", "Custom", "CV", "EV6", "EV9", "Forte", "K5", "K900", "Niro EV", "Rio", "Sorento", "Soul", "Sportage", "Stinger", "Telluride"
    ],
    "Lexus": [
      "Custom", "ES", "GX", "IS", "LC", "LS", "LX", "NX", "RC", "RX", "UX"
    ],
    "Lucid": [
      "Air", "Custom", "Gravity"
    ],
    "Mercedes-Benz": [
      "A-Class", "AMG-GT", "C-Class", "CLA", "Custom", "E-Class", "EQA", "EQB", "EQC", "EQE", "EQS", "EQV",
      "G-Class", "GLA", "GLB", "GLC", "GLE", "GLS", "Maybach S-Class", "S-Class"
    ],
    "Nissan": [
      "Altima", "Ariya", "Armada", "Custom", "E70Z", "Frontier", "GT-R", "LEAF", "Max-Out", "Maxima", "Murano",
      "Pathfinder", "Rogue", "Sentra", "Titan"
    ],
    "Polestar": [
      "Custom", "Polestar 2", "Polestar 3", "Polestar 4"
    ],
    "Porsche": [
      "718", "911", "Boxster", "Cayenne", "Cayman", "Custom", "Macan", "Panamera", "Taycan", "Taycan Cross Turismo"
    ],
    "Rivian": [
      "Custom", "R1S", "R1T"
    ],
    "Subaru": [
      "Ascent", "BRZ", "Crosstrek", "Custom", "Forester", "Impreza", "Legacy", "Outback", "WRX"
    ],
    "Tesla": [
      "Cybertruck", "Custom", "Model 3", "Model S", "Model X", "Model Y"
    ],
    "Toyota": [
      "4Runner", "Avalon", "C-HR", "Camry", "Corolla", "Custom", "GR86", "Highlander", "Land Cruiser", "Mirai",
      "Prius", "RAV4", "Sienna", "Supra", "Tacoma", "Tundra"
    ],
    "Volkswagen": [
      "Arteon", "Atlas", "Atlas Cross Sport", "Custom", "Golf", "Golf GTI", "ID Buzz", "ID.3", "ID.4", "ID.5", "ID.6",
      "Jetta", "Jetta GLI", "Passat", "Taos", "Tiguan"
    ],
    "Volvo": [
      "C40 Recharge", "Custom", "S60", "S90", "V60", "V90", "XC40", "XC60", "XC90"
    ],
    "Others": [
      "OTHER_MODEL"
    ],
  };


  final List<String> years = [
    for (int year = 2026; year >= 1995; year--) year.toString(),
  ];


  final TextEditingController titleController = TextEditingController();
  final TextEditingController makeController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  late TextEditingController locationController;
  final TextEditingController descriptionController = TextEditingController();
  String selectedVehicleType = "";

  int selectedIndex = -1; // No default selection

  @override
  Widget build(BuildContext context) {

    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(

      backgroundColor: whiteColor,

      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              children: [
                 Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                    child: Text("Vehicle Type", style: TextStyle(
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
                    items: vehicleTypes,
                    selectedIndex: selectedIndex,
                    onItemSelected: (index) {
                      print('DEBUG: Vehicle type selected - index: $index, type: ${vehicleTypes[index].title}');
                      setState(() {
                        selectedIndex = index;
                        selectedVehicleType = vehicleTypes[index].title;
                        print('DEBUG: After setState - selectedIndex: $selectedIndex, selectedVehicleType: $selectedVehicleType');
                      });
                    },
                    hasError: _showValidation && selectedIndex < 0,
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
          
                SizedBox(height: screenHeight * 0.03,),
          
                BuildInput(
                  title: "Title", 
                  label: "Title", 
                  textController: titleController,
                  validator: (value) {
                    if(value!.isEmpty) {
                      return "Title is required";
                    }
                    return null;
                  },
                  hasError: _showValidation && titleController.text.trim().isEmpty,
                ),
                BuildInput(
                  title: "Make", 
                  label: "Make", 
                  textController: makeController,
                  validator: (value) {
                    if(value!.isEmpty) {
                      return "Make is required";
                    }
                    return null;
                  },
                  hasError: _showValidation && makeController.text.trim().isEmpty,
                ),
          
                BuildInput(
                  title: "Model", 
                  label: "Model", 
                  textController: modelController,
                  validator: (value) {
                    if(value!.isEmpty) {
                      return "Model is required";
                    }
                    return null;
                  },
                  hasError: _showValidation && modelController.text.trim().isEmpty,
                ),
          
                BuildInput(
                  title: "Year", 
                  label: "Year", 
                  textController: yearController,
                  validator: (value) {
                    if(value!.isEmpty) {
                      return "Year is required";
                    }
                    return null;
                  },
                  hasError: _showValidation && yearController.text.trim().isEmpty,
                ),
          
                BuildInput(
                  title: "Price", 
                  label: "Price", 
                  textController: priceController,
                  validator: (value) {
                    if(value!.isEmpty) {
                      return "Price is required";
                    }
                    return null;
                  },
                  hasError: _showValidation && priceController.text.trim().isEmpty,
                ),
          
                BuildInput(
                  title: "Location", 
                  label: "Location", 
                  textController: locationController,
                  validator: (value) {
                    if(value!.isEmpty) {
                      return "Location is required";
                    }
                    return null;
                  },
                  hasError: _showValidation && locationController.text.trim().isEmpty,
                ),
                BuildMultilineInput(
                  title: "Description", 
                  label: "Description", 
                  controller: descriptionController,
                  validator: (value) {
                    if(value == null || value.trim().isEmpty) {
                      return "Description is required";
                    }
                    return null;
                  },
                  hasError: _showValidation && descriptionController.text.trim().isEmpty,
                ),
          
                SizedBox(height: screenHeight * 0.01,),
          
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
                    bool typeSelected = selectedIndex >= 0;
                    print('DEBUG: Vehicle validation check - selectedIndex: $selectedIndex, typeSelected: $typeSelected, _showValidation: $_showValidation');
                    bool makeSelected = makeController.text.isNotEmpty;
                    bool modelSelected = modelController.text.isNotEmpty;
                    bool yearSelected = yearController.text.isNotEmpty;
                    
                    if (!typeSelected) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please select a vehicle type'),
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                    
                    if (isValid && typeSelected && makeSelected && modelSelected && yearSelected) {
                      _listingInputController.setBasicDetails(
                        title: titleController.text,
                        description: descriptionController.text,
                        price: int.parse(priceController.text),
                        mainCategory: "vehicles",
                        subCategory: selectedVehicleType,
                        location: locationController.text,
                        latitude: _locationController.latitude.value,//latitude
                        longitude: _locationController.longitude.value,//longitude
                        make: makeController.text,
                        model: modelController.text,
                        year: int.parse(yearController.text)
                      );
            
                      Get.to(AddPictures());
                    }
                  },
                ),
          
                SizedBox(height: screenHeight * 0.03,),
          
          
              ],
            ),
          ),
        ),
      ),
    );
  }
}
