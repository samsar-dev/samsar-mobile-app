import 'package:get/get.dart';
import 'package:samsar/models/listing/trending/trending_listings.dart';
import 'package:samsar/services/listing/trending_listing_service.dart';

class TrendingListingController extends GetxController {
  final TrendingListingService _service = TrendingListingService();

  var listings = <Item>[].obs;
  var isLoading = false.obs;
  var isMoreLoading = false.obs;
  var hasMore = true.obs;

  int _page = 1;
  final int _limit = 10;

  // Filter: Only main category
  var selectedCategory = ''.obs; // vehicle or realEstate

  @override
  void onInit() {
    fetchListings(isInitial: true);
    super.onInit();
  }

  Future<void> fetchListings({bool isInitial = false}) async {
    if (isInitial) {
      _page = 1;
      listings.clear();
      hasMore.value = true;
    } else {
      if (!hasMore.value) return;
      isMoreLoading.value = true;
    }

    isLoading.value = isInitial;

    final response = await _service.getTrendingListingsService();

    if (response.successResponse != null) {
      final trending = TrendingListings.fromJson(response.successResponse!);
      final newItems = trending.data?.items ?? [];

      final filtered = _applyCategoryFilter(newItems);
      listings.addAll(filtered);

      if (newItems.length < _limit) {
        hasMore.value = false;
      } else {
        _page++;
      }
    }

    isLoading.value = false;
    isMoreLoading.value = false;
  }

  List<Item> _applyCategoryFilter(List<Item> items) {
    if (selectedCategory.isEmpty) return items;

    return items
        .where((item) =>
            item.category?.toLowerCase() == selectedCategory.value.toLowerCase())
        .toList();
  }

  void setCategory(String category) {
    selectedCategory.value = category;
    fetchListings(isInitial: true);
  }

  void loadMore() {
    if (!isLoading.value && !isMoreLoading.value) {
      fetchListings();
    }
  }
}
