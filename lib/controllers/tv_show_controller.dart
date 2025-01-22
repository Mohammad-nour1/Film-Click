/*import 'package:get/get.dart';
import 'package:filmclick/models/tv_model.dart';
import 'package:filmclick/services/fetchs_service.dart';

class TvShowController extends GetxController {
  final MovieService _movieService = MovieService();

  var tvShows = <TvShow>[].obs;
  var isLoading = true.obs;
  var selectedTvShow = Rxn<TvShow>();

  get tvShowCast => null;

  get currentTvShow => null;

  get currentTrailer => null; // ✅ إضافة متغير للمسلسل المحدد

  @override
  void onInit() {
    super.onInit();
    fetchTvShows();
  }

  void fetchTvShows() async {
    try {
      isLoading(true);
      final data = await _movieService.fetchPopularTvShows();
      tvShows.value = data;
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading(false);
    }
  }

  void setTvShows(List<TvShow> tv) {
    tvShows.value = tv;
  }

  List<TvShow> getTvShows() => tvShows;

  // ✅ إضافة دالة لتحديث المسلسل المحدد
  void setTvShow(TvShow tvShow) {
    selectedTvShow.value = tvShow;
  }

  // Add the method to fetch TV show videos (e.g., trailers)
  Future<void> getTvShowVideos(int tvShowId) async {
    try {
      var video = await _movieService.fetchTvShowVideos(tvShowId); // Call service method to fetch video
      // Handle the video result here (e.g., set a state or navigate)
    } catch (e) {
      print("Error fetching TV show video: $e");
    }
  }
}
*/
