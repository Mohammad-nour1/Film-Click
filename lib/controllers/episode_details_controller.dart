import 'package:filmclick/services/fetchs_service.dart';
import 'package:get/get.dart';

class EpisodeDetailsController extends GetxController {
  var episodeDetails = {}.obs;
  var isLoading = true.obs;
  final MovieService _movieService = MovieService();

  void fetchEpisodeDetails(int tvShowId, int seasonNumber, int episodeNumber) async {
    try {
      isLoading(true);
      final data = await _movieService.fetchEpisodeDetails(tvShowId, seasonNumber, episodeNumber);
      episodeDetails.assignAll(data);
    } catch (e) {
      print("Error fetching episode details: $e");
    } finally {
      isLoading(false);
    }
  }
}
