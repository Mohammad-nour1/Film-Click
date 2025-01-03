import 'package:filmclick/models/tv_model.dart';
import 'package:filmclick/services/fetchs_service.dart';
import 'package:get/get.dart';
import 'package:filmclick/models/movie_model.dart'; // تأكد من استيراد نموذج Movie

class DetailsController extends GetxController {
  final MovieService _movieService = MovieService();

  // المتغيرات التي ستخزن بيانات الفيلم والمسلسل
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

  // قائمة الممثلين (طاقم العمل)
  var cast = <Map<String, dynamic>>[].obs;

  // المتغيرات التي تحتوي على روابط الفيديوهات
  var trailerVideoKey = ''.obs;
  var mainVideoKey = ''.obs;

  // دالة لتعيين بيانات الفيلم
  void setMovie(Movie m) {
    movie.value = m;
    fetchCast(m.id, isMovie: true);  // جلب الممثلين بعد تعيين الفيلم
    fetchVideos(m.id, isMovie: true); // جلب الفيديوهات بعد تعيين الفيلم
  }

  // دالة لتعيين بيانات المسلسل
  void setTvShow(TvShow tv) {
    tvShow.value = tv;
    fetchCast(tv.id, isMovie: false);  // جلب الممثلين بعد تعيين المسلسل
    fetchVideos(tv.id, isMovie: false); // جلب الفيديوهات بعد تعيين المسلسل
  }

  // دالة لإرجاع الفيلم
  Movie getMovie() {
    return movie.value;
  }

  // دالة لإرجاع المسلسل
  TvShow getTvShow() {
    return tvShow.value;
  }

  // دالة لجلب الفيديوهات (التريلر والفيديو الرئيسي)
  void fetchVideos(int id, {bool isMovie = true}) async {
    try {
      final videos = await _movieService.fetchVideos(id, isMovie: isMovie);
      // جلب تريلر
      trailerVideoKey.value = videos.firstWhere(
        (video) => video['type'] == 'Trailer',
        orElse: () => {'key': ''},
      )['key'];

      // جلب الفيديو الرئيسي (Teaser)
      mainVideoKey.value = videos.firstWhere(
        (video) => video['type'] == 'Teaser',
        orElse: () => {'key': ''},
      )['key'];
    } catch (e) {
      print('Error fetching videos: $e');
    }
  }

  // دالة لجلب الممثلين (طاقم العمل)
  void fetchCast(int id, {bool isMovie = true}) async {
    try {
      cast.value = await _movieService.fetchCast(id, isMovie: isMovie);
    } catch (e) {
      print('Error fetching cast: $e');
    }
  }

  // إضافة دالة لجلب الفيديو الرئيسي (Teaser)
  void fetchMainVideo(int id) async {
    try {
      final videos = await _movieService.fetchVideos(id, isMovie: true); // أو false حسب نوع الفيديو
      // جلب الفيديو الرئيسي (Teaser)
      mainVideoKey.value = videos.firstWhere(
        (video) => video['type'] == 'Teaser',
        orElse: () => {'key': ''},
      )['key'];
    } catch (e) {
      print('Error fetching main video: $e');
    }
  }
}
