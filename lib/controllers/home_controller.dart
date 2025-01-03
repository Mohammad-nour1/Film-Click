import 'package:filmclick/models/movie_model.dart';
import 'package:get/get.dart';

import '../services/fetchs_service.dart';

class HomeController extends GetxController {
  final movies = <Movie>[].obs;
  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchMovies();
  }

  void fetchMovies() async {
    try {
      isLoading(true);
      final data = await MovieService().fetchPopularMovies();
      movies.value = data;
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading(false);
    }
  }
}
