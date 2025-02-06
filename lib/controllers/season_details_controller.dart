/*import 'package:filmclick/models/movie_model.dart';
import 'package:filmclick/services/fetchs_service.dart';
import 'package:get/get.dart';

class SeasonDetailsController extends GetxController {
  final MovieService _movieService = MovieService();
  
  var isLoading = true.obs;
  var episodes = <Episode>[].obs;

  Future<void> fetchSeasonDetails(int tvShowId, int seasonNumber) async {
    try {
      isLoading(true);
      var fetchedEpisodes = await _movieService.fetchSeasonEpisodes(tvShowId, seasonNumber);
      episodes.assignAll(fetchedEpisodes);
    } catch (e) {
      print("Error fetching season details: $e");
    } finally {
      isLoading(false);
    }
  }
}
*/