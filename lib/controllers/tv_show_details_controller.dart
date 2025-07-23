/*import 'package:filmclick/models/movie_model.dart';
import 'package:filmclick/services/cast_service.dart';
import 'package:filmclick/services/fetchs_service.dart';
import 'package:filmclick/services/video_service.dart';
import 'package:get/get.dart';

class TvShowDetailsController extends GetxController {
  final MovieService _movieService = MovieService();

  var isLoading = true.obs;
  var tvShow = Rx<TvShow?>(null); // Using `Rx<TvShow?>` to support null value during loading
  var isFavorite = false.obs; // To track the favorite status

  // Fetching TV show details
  Future<void> fetchTvShowDetails(int id) async {
    try {
      isLoading(true);
      final fetchedTvShow = await _movieService.fetchTvById(id);
      tvShow.value = fetchedTvShow as TvShow?;
      fetchCast(id);
      fetchVideos(id);
      checkIfFavorite(id); // Check if this TV show is marked as favorite
    } catch (e) {
      print("Error fetching TV show details: $e");
    } finally {
      isLoading(false);
    }
  }

  // Fetching videos
  void fetchVideos(int id) async {
    try {
      final videos = await _movieService.fetchVideos(id, isMovie: false);
      VideoService().updateVideoKeys(videos);
    } catch (e) {
      print('Error fetching videos: $e');
    }
  }

  // Fetching cast
  void fetchCast(int id) async {
    try {
      final cast = await _movieService.fetchCast(id, isMovie: false);
      CastService().updateCast(cast);
    } catch (e) {
      print('Error fetching cast: $e');
    }
  }

  // Checking if the TV show is marked as favorite
  void checkIfFavorite(int tvShowId) {
    // You can implement your logic to check if the TV show is in the favorite list
    // For example, checking in a local database or using a shared preference
    isFavorite.value = false; // Replace with actual logic
  }

  // Toggle favorite status
  void toggleFavorite(int tvShowId) {
    isFavorite.value = !isFavorite.value; // Toggle the favorite state
    // You can add logic here to save the favorite status (e.g., saving to local storage or API)
  }
}*/
