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
