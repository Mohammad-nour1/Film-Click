import 'package:filmclick/models/movie_model.dart';
import 'package:filmclick/services/cast_service.dart';
import 'package:filmclick/services/fetchs_service.dart';
import 'package:filmclick/services/video_service.dart';
import 'package:get/get.dart';

class TvShowDetailsController extends GetxController {
  final MovieService _movieService = MovieService();

  var tvShow = TvShow(
    adult: false,
    backdropPath: '',
    genreIds: [],
    id: 0,
    originCountry: [],
    originalLanguage: '',
    originalName: '',
    overview: '',
    popularity: 0.0,
    posterPath: '',
    firstAirDate: '',
    name: '',
    voteAverage: 0.0,
    voteCount: 0,
    video: false,
    seasons: [],
    cast: [],
  ).obs;

  // دالة تعيين المسلسل
  void setTvShow(TvShow tv) {
    tvShow.value = tv;
    fetchCast(tv.id);
    fetchVideos(tv.id);
  }

  // دالة للحصول على المسلسل الحالي
  TvShow getTvShow() => tvShow.value;

  // جلب الفيديوهات
  void fetchVideos(int id) async {
    try {
      final videos = await _movieService.fetchVideos(id, isMovie: false);
      VideoService().updateVideoKeys(videos);
    } catch (e) {
      print('Error fetching videos: $e');
    }
  }

  // جلب الممثلين
  void fetchCast(int id) async {
    try {
      CastService().updateCast(await _movieService.fetchCast(id, isMovie: false));
    } catch (e) {
      print('Error fetching cast: $e');
    }
  }
}