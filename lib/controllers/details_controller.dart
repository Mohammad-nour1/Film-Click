import 'package:filmclick/services/fetchs_service.dart';
import 'package:get/get.dart';
import 'package:filmclick/models/movie_model.dart';

class DetailsController extends GetxController {
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

  var cast = <Map<String, dynamic>>[].obs;

  var trailerVideoKey = ''.obs;
  var mainVideoKey = ''.obs;

  var isFavorite = false.obs;
  final RxList<Map<String, dynamic>> favorites = <Map<String, dynamic>>[].obs;

  void setMovie(Movie m) {
    movie.value = m;
    checkIfFavorite(m.id);
    fetchCast(m.id, isMovie: true);
    fetchVideos(m.id, isMovie: true);
  }

  void setTvShow(TvShow tv) {
    tvShow.value = tv;
    checkIfFavorite(tv.id);
    fetchCast(tv.id, isMovie: false);
    fetchVideos(tv.id, isMovie: false);
  }

  void fetchVideos(int id, {bool isMovie = true}) async {
    try {
      final videos = await _movieService.fetchVideos(id, isMovie: isMovie);
      trailerVideoKey.value = videos.firstWhere(
        (video) => video['type'] == 'Trailer',
        orElse: () => {'key': ''},
      )['key'];
      mainVideoKey.value = videos.firstWhere(
        (video) => video['type'] == 'Teaser',
        orElse: () => {'key': ''},
      )['key'];
    } catch (e) {
      print('Error fetching videos: $e');
    }
  }

  void fetchCast(int id, {bool isMovie = true}) async {
    try {
      cast.value = await _movieService.fetchCast(id, isMovie: isMovie);
    } catch (e) {
      print('Error fetching cast: $e');
    }
  }

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

  void checkIfFavorite(int id) {
    isFavorite.value = favorites.any((item) => item['id'] == id);
  }

  void setMovieFromFavorites(Map<String, dynamic> favorite) {
    movie.value = Movie(
      id: favorite['id'],
      title: favorite['title'],
      posterPath: favorite['posterPath'],
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
