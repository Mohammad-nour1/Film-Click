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

   
  // دالة لجلب جميع البيانات
  Future<void> fetchData() async {
    try {
      isLoading(true); // بدء حالة التحميل

     
      

      final popularTvShowsData = await _movieService.fetchPopularTvShows();
      // تأكد من أن البيانات ليست فارغة قبل تحويلها
      tvShows.value = List<TvShow>.from(popularTvShowsData);

    
      
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
