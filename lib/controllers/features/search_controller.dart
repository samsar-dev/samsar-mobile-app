import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:samsar/models/search/search_query.dart';
import 'package:samsar/widgets/custom_snackbar/custom_snackbar.dart';


class SearchModuleController extends GetxController{

  final Dio _dio = Dio();

  RxList<SearchIndividualListingModel> searchResults = <SearchIndividualListingModel>[].obs;
  RxBool isLoading = false.obs;
  RxBool hasMore = true.obs;
  RxInt currentPage = 1.obs;
  final int limit = 10;
  late SearchQuery lastQuery;

  Future<void> searchController(SearchQuery query, {bool reset = false}) async {

    if (isLoading.value || (!hasMore.value && !reset)) return;


    if (reset) {
      searchResults.clear();
      currentPage.value = 1;
      hasMore.value = true;
      lastQuery = query;
    }

    isLoading.value = true;

    try {

      final response = await _dio.get(
        "https://samsar-backend-production.up.railway.app/api/listings/search",
        queryParameters: query.copyWith(page: currentPage.value, limit: limit).toQueryParams(),
      );

      final data = response.data;

      // showCustomSnackbar("We are getting data", false);

      if (data['success'] == true) {
        final items = data['data']['items'] as List;
        // print("items are: $items");
        searchResults.addAll(
          items.map((e) => SearchIndividualListingModel.fromJson(e)).toList(),
        );
        hasMore.value = data['data']['hasMore'];
        currentPage++;
      } else {
        showCustomSnackbar("Search failed: ${data['error']}", true);
        return;
      }

      showCustomSnackbar("We are getting the data", false);
      
    } catch (e) {
      showCustomSnackbar("Search error: $e", true);
    } finally {
      isLoading.value = false;
    }
  }
  
}