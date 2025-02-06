import 'package:filmclick/models/movie_model.dart';
import 'package:filmclick/services/fetchs_service.dart';
import 'package:get/get.dart';

class TvShowsController extends GetxController {
  final MovieService _movieService = MovieService();

  var isLoading = true.obs;
  var tvShows = <TvShow>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchTvShows();
  }

  void fetchTvShows() async {
    try {
      isLoading(true);
      var fetchedTvShows = await _movieService.fetchPopularTvShows();
      tvShows.assignAll(fetchedTvShows as Iterable<TvShow>);
    } catch (e) {
      print("Error fetching TV shows: $e");
    } finally {
      isLoading(false);
    }
  }
}
