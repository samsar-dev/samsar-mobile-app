import 'package:flutter/material.dart';
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
              child: Text(_locationController.errorMessage.value)
            )
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