/*import 'package:filmclick/models/movie_model.dart';
import 'package:filmclick/services/fetchs_service.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class MovieController extends GetxController {
  final MovieService _movieService = MovieService();

  var movies = <Movie>[].obs;
  var isLoading = true.obs;
  var selectedMovie = Rxn<Movie>();

  get movieCast => null;

  get currentMainVideo => null;

  get currentTrailer => null;

  get currentMovie => null; // ✅ إضافة متغير للفيلم المحدد

  @override
  void onInit() {
    super.onInit();
    fetchMovies();
  }

  void fetchMovies() async {
    try {
      isLoading(true);
      movies.value = await _movieService.fetchPopularMovies();
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading(false);
    }
  }

  void setMovies(List<Movie> m) {
    movies.value = m;
  }

  List<Movie> getMovies() => movies;

  // ✅ إضافة دالة لتحديث الفيلم المحدد
  void setMovie(Movie movie) {
    selectedMovie.value = movie;
  }


  // Add the method to fetch all videos for a movie (e.g., trailers and other videos)
  Future<void> getMovieVideos(int movieId) async {
    try {
      var videos = await _movieService.fetchMovieVideos(movieId); // Call service method to fetch videos
      // Handle the list of videos here (e.g., set a state or display)
    } catch (e) {
      print("Error fetching movie videos: $e");
    }
  }
}*/
import 'package:get/get.dart';
import '../models/movie_model.dart';
import '../services/fetchs_service.dart';

class MovieController extends GetxController {
  final MovieService _movieService = MovieService();

  var movies = <Movie>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchMovies();
  }

  void fetchMovies() async {
    try {
      isLoading(true);
      movies.value = await _movieService.fetchPopularMovies();
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading(false);
    }
  }
}
