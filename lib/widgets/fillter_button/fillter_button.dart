import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samsar/constants/color_constants.dart';

class FillterButton extends StatefulWidget {
  const FillterButton({super.key});

  @override
  State<FillterButton> createState() => _FillterButtonState();
}

class _FillterButtonState extends State<FillterButton> {
  String? selectedSort;
  String? selectedSubcategory;
  String? selectedListingType;
  String? selectedCity;
  int? selectedYear;

  final List<String> sortOptions = [
    "Newest First",
    "Price: High to Low",
    "Price: Low to High",
    "Location: A to Z",
    "Location: Z to A"
  ];

  final List<String> subcategories = ["Tractor", "Van", "Bus", "Car", "Motorcycle"];
  final List<String> listingTypes = ["For Sale", "For Rent"];
  final List<String> cities = ["Damascus", "Aleppo", "Homs", "Lattakia", "Hama", "Deir Ezzor", "Hasekeh", "Qamishli", "Raqqa", "Tartous", "Ldlib", "Dara", "Sweden", "Quneitra"];
  final List<int> years = List.generate(2025 - 1990 + 1, (index) => 2025 - index);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: ElevatedButton.icon(
          onPressed: () {
            Get.dialog(
              Dialog(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Wrap(
                          runSpacing: 20,
                          spacing: 20,
                          children: [
                            // Sort Dropdown
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Sort By", style: TextStyle(fontWeight: FontWeight.bold)),
                                DropdownButton<String>(
                                  value: selectedSort,
                                  hint: const Text("Select Sort Option"),
                                  items: sortOptions
                                      .map((option) => DropdownMenuItem(
                                            value: option,
                                            child: Text(option),
                                          ))
                                      .toList(),
                                  onChanged: (val) {
                                    setState(() {
                                      selectedSort = val;
                                    });
                                  },
                                ),
                              ],
                            ),

                            // Subcategory Dropdown
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Subcategory", style: TextStyle(fontWeight: FontWeight.bold)),
                                DropdownButton<String>(
                                  value: selectedSubcategory,
                                  hint: const Text("Select Subcategory"),
                                  items: subcategories
                                      .map((sub) => DropdownMenuItem(
                                            value: sub,
                                            child: Text(sub),
                                          ))
                                      .toList(),
                                  onChanged: (val) {
                                    setState(() {
                                      selectedSubcategory = val;
                                    });
                                  },
                                ),
                              ],
                            ),

                            // Listing Type Toggle Buttons
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Listing Type", style: TextStyle(fontWeight: FontWeight.bold)),
                                Row(
                                  children: listingTypes.map((type) {
                                    final isSelected = selectedListingType == type;
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 8.0),
                                      child: ChoiceChip(
                                        label: Text(
                                          type,
                                          style: TextStyle(
                                            color: isSelected ? whiteColor : blackColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        selected: isSelected,
                                        selectedColor: blueColor,
                                        backgroundColor: whiteColor,
                                        side: BorderSide(color: isSelected ? blueColor : Colors.grey.shade300),
                                        onSelected: (_) {
                                          setState(() {
                                            selectedListingType = type;
                                          });
                                        },
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),

                            // City Dropdown
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("City", style: TextStyle(fontWeight: FontWeight.bold)),
                                DropdownButton<String>(
                                  value: selectedCity,
                                  hint: const Text("Select City"),
                                  items: cities
                                      .map((city) => DropdownMenuItem(
                                            value: city,
                                            child: Text(city),
                                          ))
                                      .toList(),
                                  onChanged: (val) {
                                    setState(() {
                                      selectedCity = val;
                                    });
                                  },
                                ),
                              ],
                            ),

                            // Year Dropdown
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Year", style: TextStyle(fontWeight: FontWeight.bold)),
                                DropdownButton<int>(
                                  value: selectedYear,
                                  hint: const Text("Select Year"),
                                  items: years
                                      .map((year) => DropdownMenuItem(
                                            value: year,
                                            child: Text(year.toString()),
                                          ))
                                      .toList(),
                                  onChanged: (val) {
                                    setState(() {
                                      selectedYear = val;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // Apply & Reset Buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  selectedSort = null;
                                  selectedSubcategory = null;
                                  selectedListingType = null;
                                  selectedCity = null;
                                  selectedYear = null;
                                });
                              },
                              child: const Text("Reset"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // Handle filter apply logic
                                Get.back();
                              },
                              child: const Text("Apply"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          icon: const Icon(Icons.filter_list),
          label: const Text("Filter"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey.shade200,
            foregroundColor: Colors.black87,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          ),
        ),
      ),
    );
  }
}
