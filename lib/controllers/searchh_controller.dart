import 'package:filmclick/models/movie_model.dart';
import 'package:get/get.dart';
import 'package:filmclick/api/api_service.dart';
class SearchhController extends GetxController {
  final ApiService _apiService = ApiService();  
  var isLoading = false.obs;
  var movies = <Movie>[].obs;
  var tvShows = <TvShow>[].obs;
  var searchText = ''.obs; // نص البحث
  var isSearchViewOpen = false.obs; // حالة نافذة البحث

  // دالة البحث عن الأفلام والمسلسلات
  Future<void> search(String query) async {
    if (query.isEmpty) return;

    isLoading.value = true;

    try {
      final movieData = await _apiService.getRequest('search/movie?query=$query');
      final tvData = await _apiService.getRequest('search/tv?query=$query');

      movies.value = (movieData['results'] as List)
          .map((json) => Movie.fromJson(json))
          .toList();

      tvShows.value = (tvData['results'] as List)
          .map((json) => TvShow.fromJson(json))
          .toList();

    } catch (e) {
      print("Error searching: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // دالة لتبديل حالة نافذة البحث
  void toggleSearchView() {
    isSearchViewOpen.value = !isSearchViewOpen.value;
  }
}
