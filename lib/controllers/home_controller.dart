import 'package:filmclick/models/movie_model.dart';
import 'package:get/get.dart';
import '../services/fetchs_service.dart';

class HomeController extends GetxController {
  // خدمة جلب البيانات
  final MovieService _movieService = MovieService();

  // المتغيرات القابلة للمراقبة
  var movies = <Movie>[].obs; // قائمة الأفلام
  var tvShows = <TvShow>[].obs; // قائمة المسلسلات
  var upcomingMovies = <Movie>[].obs; // قائمة الأفلام القادمة
  var isLoading = true.obs; // حالة التحميل

  @override
  void onInit() {
    super.onInit();
    fetchData(); // جلب البيانات عند بدء التطبيق
  }

  // دالة لجلب جميع البيانات
  Future<void> fetchData() async {
    try {
      isLoading(true); // بدء حالة التحميل

      final popularMoviesData = await _movieService.fetchPopularMovies();
      // تأكد من أن البيانات ليست فارغة قبل تحويلها
      movies.value = List<Movie>.from(popularMoviesData);

      final popularTvShowsData = await _movieService.fetchPopularTvShows();
      // تأكد من أن البيانات ليست فارغة قبل تحويلها
      tvShows.value = List<TvShow>.from(popularTvShowsData);

      final upcomingMoviesData = await _movieService.fetchUpcomingMovies();
      // تأكد من أن البيانات ليست فارغة قبل تحويلها
      upcomingMovies.value = List<Movie>.from(upcomingMoviesData);
    } catch (e) {
      print("Error fetching data: $e"); // طباعة الخطأ في حال حدوث مشكلة
    } finally {
      isLoading(false);
    }
  }

  // دالة لتحديث البيانات (تستخدم مع RefreshIndicator)
  Future<void> refreshData() async {
    fetchData(); // إعادة جلب البيانات
  }
}
