/*import 'package:filmclick/models/movie_model.dart';
import 'package:filmclick/services/cast_service.dart';
import 'package:filmclick/services/fetchs_service.dart';
import 'package:filmclick/services/video_service.dart';
import 'package:get/get.dart';

class MovieDetailsController extends GetxController {
  final MovieService _movieService = MovieService();

  var movie = Movie(
    adult: false,
    backdropPath: '',
    genreIds: [],
    id: 0,
    originalLanguage: '',
    originalTitle: '',
    popularity: 0.0,
    title: '',
    overview: '',
    releaseDate: '',
    voteAverage: 0.0,
    voteCount: 0,
    video: false,
    posterPath: '',
    cast: [],
  ).obs;

  // دالة تعيين الفيلم
  void setMovie(Movie m) {
    movie.value = m;
    fetchCast(m.id);
    fetchVideos(m.id);
  }

  // دالة للحصول على الفيلم الحالي
  Movie getMovie() => movie.value;

  // جلب الفيديوهات
  void fetchVideos(int id) async {
    try {
      final videos = await _movieService.fetchVideos(id, isMovie: true);
      VideoService().updateVideoKeys(videos);
    } catch (e) {
      print('Error fetching videos: $e');
    }
  }

  // جلب الممثلين
  void fetchCast(int id) async {
    try {
      CastService().updateCast(await _movieService.fetchCast(id, isMovie: true));
    } catch (e) {
      print('Error fetching cast: $e');
    }
  }
}*/
