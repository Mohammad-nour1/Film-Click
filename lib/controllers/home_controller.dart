import 'package:filmclick/models/movie_model.dart';
import 'package:get/get.dart';
import '../services/fetchs_service.dart';

class HomeController extends GetxController {
  final MovieService _movieService = MovieService();

  var movies = <Movie>[].obs;
  var tvShows = <TvShow>[].obs;
  var upcomingMovies = <Movie>[].obs; 
  var isLoading = true.obs; 

  @override
  void onInit() {
    super.onInit();
    fetchData(); 
  }

  
  Future<void> fetchData() async {
    try {
      isLoading(true);

      final popularMoviesData = await _movieService.fetchPopularMovies();
      
      movies.value = List<Movie>.from(popularMoviesData);

      final popularTvShowsData = await _movieService.fetchPopularTvShows();
      
      tvShows.value = List<TvShow>.from(popularTvShowsData);

      final upcomingMoviesData = await _movieService.fetchUpcomingMovies();
      
      upcomingMovies.value = List<Movie>.from(upcomingMoviesData);
    } catch (e) {
      print("Error fetching data: $e"); 
    } finally {
      isLoading(false);
    }
  }

  // دالة لتحديث البيانات (تستخدم مع RefreshIndicator)
  Future<void> refreshData() async {
    fetchData(); // إعادة جلب البيانات
  }
}
