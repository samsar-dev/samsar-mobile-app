import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:samsar/constants/color_constants.dart';
import 'package:samsar/controllers/features/location_controller.dart';
import 'package:samsar/views/chats/chat_list_view.dart';
import 'package:samsar/views/listing_features/create_listing/create_listing_view.dart';
import 'package:samsar/views/listing_features/favourite_listings/favourite_listings.dart';
import 'package:samsar/views/listing_feed/listing_feed_view.dart';
import 'package:samsar/views/profile_and_settings/profile_and_settings.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  int _currIndex = 0;

  List<Widget> get pages =>  [
    ListingFeedView(),
    FavouriteListings(key: ValueKey(_currIndex),),
    CreateListingView(),
    ChatListView(),
    ProfileAndSettings()
  ];

  final LocationController _locationController = Get.put(LocationController());


  void setPageIndex(int index) {
    setState(() {
      _currIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {


        if(_locationController.isLoading.value) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if(_locationController.errorMessage.isNotEmpty) {
          return Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _locationController.errorMessage.value,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _locationController.errorMessage.value.contains("permanently denied")
                          ? () {
                              // Open app settings if permissions are permanently denied
                              Geolocator.openAppSettings();
                            }
                          : () {
                              _locationController.getCurrentLocation();
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _locationController.errorMessage.value.contains("permanently denied") 
                            ? Colors.grey 
                            : blueColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 2,
                      ),
                      child: Text(
                        _locationController.errorMessage.value.contains("permanently denied")
                            ? 'Open Settings'
                            : 'Retry',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }


        return Scaffold(
        
          body: IndexedStack(
            index: _currIndex,
            children: pages,
          ),
        
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: setPageIndex,
            currentIndex: _currIndex,
            backgroundColor: whiteColor,
            selectedItemColor: blueColor,
            unselectedItemColor: greyColor,
            items: [
              BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.house), label: "Home"),
              BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.heart), label: "favourites"),
              BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.plus), label: "listing"),
              BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.comments), label: "chats"),
              BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.user), label: "Person"),
            ],
          ),
        );
      }
    );
  }
}