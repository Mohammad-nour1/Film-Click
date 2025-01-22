import 'package:filmclick/models/tv_model.dart';
import 'package:filmclick/services/fetchs_service.dart';
import 'package:get/get.dart';
import 'package:filmclick/models/movie_model.dart';

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

  // للتحقق من إذا كان العنصر مضافًا إلى المفضلة
  var isFavorite = false.obs;
  final RxList<Map<String, dynamic>> favorites = <Map<String, dynamic>>[].obs;

  // دالة لتعيين بيانات الفيلم
  void setMovie(Movie m) {
    movie.value = m;
    checkIfFavorite(m.id); // تحقق من حالة الفيلم إذا كان مضافًا إلى المفضلة
    fetchCast(m.id, isMovie: true); // جلب الممثلين بعد تعيين الفيلم
    fetchVideos(m.id, isMovie: true); // جلب الفيديوهات بعد تعيين الفيلم
  }

  // دالة لتعيين بيانات المسلسل
  void setTvShow(TvShow tv) {
    tvShow.value = tv;
    checkIfFavorite(tv.id); // تحقق من حالة المسلسل إذا كان مضافًا إلى المفضلة
    fetchCast(tv.id, isMovie: false); // جلب الممثلين بعد تعيين المسلسل
    fetchVideos(tv.id, isMovie: false); // جلب الفيديوهات بعد تعيين المسلسل
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

  // دالة لتبديل حالة المفضلة
  void toggleFavorite(int i) {
    final currentItem = movie.value.id != 0 ? movie.value : tvShow.value;
    final isMovie = movie.value.id != 0;

    if (isMovie && currentItem is Movie) {
      if (isFavorite.value) {
        favorites.removeWhere((item) => item['id'] == currentItem.id);
        isFavorite.value = false;
      } else {
        favorites.add({
          'id': currentItem.id,
          'title': currentItem.title,
          'posterPath': currentItem.posterPath,
          'type': 'movie',
        });
        isFavorite.value = true;
      }
    } else if (currentItem is TvShow) {
      if (isFavorite.value) {
        favorites.removeWhere((item) => item['id'] == currentItem.id);
        isFavorite.value = false;
      } else {
        favorites.add({
          'id': currentItem.id,
          'title': currentItem.name,
          'posterPath': currentItem.posterPath,
          'type': 'tv',
        });
        isFavorite.value = true;
      }
    }
  }

  // تحقق إذا كان العنصر مضافًا إلى المفضلة
  void checkIfFavorite(int id) {
    isFavorite.value = favorites.any((item) => item['id'] == id);
  }

  void setMovieFromFavorites(Map<String, dynamic> favorite) {
    movie.value = Movie(
      id: favorite['id'],
      title: favorite['title'],
      posterPath: favorite['posterPath'],
      // باقي الحقول يمكن أن تظل فارغة حسب الحاجة
      adult: false,
      backdropPath: '',
      genreIds: [],
      originalLanguage: '',
      originalTitle: '',
      popularity: 0.0,
      overview: '',
      releaseDate: '',
      voteAverage: 0.0,
      voteCount: 0,
      video: false,
      cast: [],
    );
    isFavorite.value = true;
  }

  void setTvShowFromFavorites(Map<String, dynamic> favorite) {
    tvShow.value = TvShow(
      id: favorite['id'],
      name: favorite['title'],
      posterPath: favorite['posterPath'],
      // باقي الحقول يمكن أن تظل فارغة حسب الحاجة
      adult: false,
      backdropPath: '',
      genreIds: [],
      originCountry: [],
      originalLanguage: '',
      originalName: '',
      overview: '',
      popularity: 0.0,
      firstAirDate: '',
      voteAverage: 0.0,
      voteCount: 0,
      video: false,
      seasons: [],
      cast: [],
    );
    isFavorite.value = true;
  }
}
