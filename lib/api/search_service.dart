import 'package:filmclick/models/movie_model.dart';

import 'package:filmclick/api/api_service.dart';

class SearchService {
  final ApiService _apiService = ApiService();

  // دالة للبحث عن الأفلام والمسلسلات
  Future<Map<String, dynamic>> fetchSearchResults(String query) async {
    var movies = await searchMovies(query);
    var tvShows = await searchTvShows(query);
    return {'movies': movies, 'tvShows': tvShows};
  }

  // دالة للبحث عن الأفلام
  Future<List<Movie>> searchMovies(String query) async {
    final data = await _apiService.getRequest('search/movie?query=$query');
    List<dynamic> results = data['results'];
    return results.map((movieJson) => Movie.fromJson(movieJson)).toList();
  }

  // دالة للبحث عن المسلسلات
  Future<List<TvShow>> searchTvShows(String query) async {
    final data = await _apiService.getRequest('search/tv?query=$query');
    List<dynamic> results = data['results'];
    return results.map((tvJson) => TvShow.fromJson(tvJson)).toList();
  }
}

