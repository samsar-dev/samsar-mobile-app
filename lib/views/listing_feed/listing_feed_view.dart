import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samsar/constants/color_constants.dart';
import 'package:samsar/controllers/features/search_controller.dart';
import 'package:samsar/controllers/listing/trending_listing_controller.dart';
import 'package:samsar/models/search/search_query.dart';
import 'package:samsar/views/listing_features/listing_detail/listing_detail.dart';
import 'package:samsar/views/notifications/notification_view.dart';
import 'package:samsar/widgets/fillter_button/fillter_button.dart';
import 'package:samsar/widgets/listing_card/listing_card.dart';
import 'package:samsar/widgets/search_bar_widget/search_bar_widget.dart';

class ListingFeedView extends StatefulWidget {
  const ListingFeedView({super.key});

  @override
  State<ListingFeedView> createState() => _ListingFeedViewState();
}

class _ListingFeedViewState extends State<ListingFeedView> {
  final TrendingListingController controller = Get.put(TrendingListingController());
  final TextEditingController _searchController = TextEditingController();
  final SearchModuleController _searchModuleController = Get.put(SearchModuleController());

  int selectedIndex = 0;
  bool isSearching = false;
  final List<String> tabs = ['Vehicles', 'Real Estate'];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() {
    tabs[selectedIndex] == 'Vehicles' ? 
    controller.selectedCategory("vehicles") 
    : controller.selectedCategory("realEstate");
  }

  void exitSearchMode() {
    setState(() {
      isSearching = false;
      _searchController.clear();
      // Optionally reset listings
      _searchModuleController.searchController(SearchQuery(query: ""), reset: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: isSearching
              ? AppBar(
                  key: const ValueKey('searchBar'),
                  backgroundColor: whiteColor,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: exitSearchMode,
                  ),
                  title: TextField(
                    controller: _searchController,
                    autofocus: true,
                    decoration: const InputDecoration(
                      hintText: 'Search listings...',
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      final query = SearchQuery(query: value);
                      _searchModuleController.searchController(query, reset: true);
                    },
                  ),
                )
              : AppBar(
                  key: const ValueKey('defaultAppBar'),
                  backgroundColor: whiteColor,
                  title: Text(
                    "Samsar",
                    style: TextStyle(fontWeight: FontWeight.bold, color: blueColor),
                  ),
                  centerTitle: false,
                  actions: [
                    IconButton(
                      onPressed: () {
                        setState(() => isSearching = true);
                      },
                      icon: Icon(Icons.search, color: blackColor),
                    ),
                    const SizedBox(width: 3),
                    IconButton(
                      onPressed: () => Get.to(() => NotificationView()),
                      icon: Icon(Icons.notifications, color: blackColor),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Remove top search bar widget since it's now inside the AppBar
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Wrap(
                  spacing: 10,
                  children: List.generate(tabs.length, (index) {
                    return ChoiceChip(
                      showCheckmark: false,
                      label: Text(tabs[index]),
                      selected: selectedIndex == index,
                      onSelected: (bool selected) {
                        if (selected) {
                          setState(() {
                            selectedIndex = index;
                            controller.setCategory(tabs[index].toLowerCase());
                          });
                        }
                      },
                      selectedColor: blueColor,
                      backgroundColor: Colors.grey[300],
                      labelStyle: TextStyle(
                        color: selectedIndex == index ? Colors.white : Colors.black,
                      ),
                    );
                  }),
                ),
                const FillterButton(),
              ],
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.listings.isEmpty) {
                  return const Center(child: Text("No listings found."));
                }

                return NotificationListener<ScrollNotification>(
                  onNotification: (scrollInfo) {
                    if (!controller.isMoreLoading.value &&
                        scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                      controller.loadMore();
                    }
                    return false;
                  },
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await controller.fetchListings(isInitial: true);
                    },
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: controller.listings.length + (controller.isMoreLoading.value ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index < controller.listings.length) {
                          final item = controller.listings[index];
                          final hasValidImage = item.images.isNotEmpty && (item.images[0].url?.isNotEmpty ?? false);

                          return GestureDetector(
                            onTap: () => Get.to(() => ListingDetail(listingId: item.id!)),
                            child: ListingCard(
                              title: item.title ?? "No Title",
                              imageUrl: hasValidImage
                                  ? NetworkImage(item.images[0].url!)
                                  : carError,
                              description: item.description ?? '',
                              listingAction: item.listingAction ?? '',
                              subCategory: item.subCategory ?? '',
                              price: item.price ?? 0,
                            ),
                          );
                        } else {
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }
                      },
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
