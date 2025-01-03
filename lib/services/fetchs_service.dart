import 'package:filmclick/models/movie_model.dart';
 // تأكد من أنك أضفت نموذج TvShow
import 'package:filmclick/api/api_service.dart';
import 'package:filmclick/models/tv_model.dart';        // استيراد خدمة API

class MovieService {
  final ApiService _apiService = ApiService();  // خدمة الـ API

  // دالة لجلب الأفلام الأعلى تقييمًا
  Future<List<Movie>> fetchTopRatedMovies() async {
    final data = await _apiService.getRequest('movie/top_rated');
    List<dynamic> results = data['results'];
    return results.map((movieJson) => Movie.fromJson(movieJson)).toList();
  }

  // دالة لجلب الأفلام الشائعة
  Future<List<Movie>> fetchPopularMovies() async {
    final data = await _apiService.getRequest('movie/popular');
    List<dynamic> results = data['results'];
    return results.map((movieJson) => Movie.fromJson(movieJson)).toList();
  }

  // دالة لجلب الأفلام القادمة (Upcoming movies)
  Future<List<Movie>> fetchUpcomingMovies() async {
    final data = await _apiService.getRequest('movie/upcoming');
    List<dynamic> results = data['results'];
    return results.map((movieJson) => Movie.fromJson(movieJson)).toList();
  }

  // دالة لجلب مسلسل معين باستخدام ID
  Future<TvShow> fetchTvById(int id) async {
    final data = await _apiService.getRequest('tv/$id');
    return TvShow.fromJson(data);
  }

  // دالة لجلب المسلسلات الشعبية
  Future<List<TvShow>> fetchPopularTvShows() async {
    final data = await _apiService.getRequest('tv/popular');
    List<dynamic> results = data['results'];
    return results.map((tvJson) => TvShow.fromJson(tvJson)).toList();
  }

  // دالة لجلب المسلسلات الأعلى تقييمًا
  Future<List<TvShow>> fetchTopRatedTvShows() async {
    final data = await _apiService.getRequest('tv/top_rated');
    List<dynamic> results = data['results'];
    return results.map((tvJson) => TvShow.fromJson(tvJson)).toList();
  }
   Future<List<Map<String, dynamic>>> fetchVideos(int id, {bool isMovie = true}) async {
    final data = await _apiService.getRequest('${isMovie ? 'movie' : 'tv'}/$id/videos');
    List<dynamic> results = data['results'];
    return results.map((videoJson) => videoJson as Map<String, dynamic>).toList();
  }
  Future<List<Map<String, dynamic>>> fetchCast(int id, {bool isMovie = true}) async {
    final data = await _apiService.getRequest('${isMovie ? 'movie' : 'tv'}/$id/credits');
    List<dynamic> results = data['cast'];
    return results.map((castJson) => castJson as Map<String, dynamic>).toList();
  }

}
