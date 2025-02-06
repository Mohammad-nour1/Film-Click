import 'package:filmclick/models/movie_model.dart';
import 'package:filmclick/services/fetchs_service.dart';
import 'package:get/get.dart';

class MoviesController extends GetxController {
  final MovieService _movieService = MovieService();

  var isLoading = true.obs;
  var movies = <Movie>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchMovies();
  }

  void fetchMovies() async {
    try {
      isLoading(true);
      var fetchedMovies = await _movieService.fetchPopularMovies();
      movies.assignAll(fetchedMovies as Iterable<Movie>);
    } catch (e) {
      print("Error fetching movies: $e");
    } finally {
      isLoading(false);
    }
  }
}
