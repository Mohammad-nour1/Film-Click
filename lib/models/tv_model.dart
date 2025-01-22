/*class TvShow {
  final bool adult;
  final String backdropPath;
  final List<int> genreIds;
  final int id;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String posterPath;
  final String firstAirDate;
  final String name;
  final double voteAverage;
  final int voteCount;
  final bool video;
  final List<dynamic> seasons;
  final List<dynamic> cast; // ✅ إصلاح `cast`

  TvShow({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.firstAirDate,
    required this.name,
    required this.voteAverage,
    required this.voteCount,
    required this.video,
    required this.seasons,
    required this.cast, // ✅ التأكد من تمريره هنا
  });

  factory TvShow.fromJson(Map<String, dynamic> json) {
    return TvShow(
      adult: json['adult'] ?? false,
      backdropPath: json['backdrop_path'] ?? '',
      genreIds: (json['genre_ids'] as List<dynamic>?)?.map((e) => e as int).toList() ?? [],
      id: json['id'] ?? 0,
      originCountry: (json['origin_country'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
      originalLanguage: json['original_language'] ?? 'N/A',
      originalName: json['original_name'] ?? 'Unknown',
      overview: json['overview'] ?? 'No overview available',
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0.0,
      posterPath: json['poster_path'] ?? '',
      firstAirDate: json['first_air_date'] ?? 'Unknown',
      name: json['name'] ?? 'Unknown',
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      voteCount: json['vote_count'] ?? 0,
      video: json['video'] ?? false,
      seasons: json['seasons'] ?? [],
      cast: json['cast'] ?? [], // ✅ إصلاح `cast`
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'adult': adult,
      'backdrop_path': backdropPath,
      'genre_ids': genreIds,
      'id': id,
      'origin_country': originCountry,
      'original_language': originalLanguage,
      'original_name': originalName,
      'overview': overview,
      'popularity': popularity,
      'poster_path': posterPath,
      'first_air_date': firstAirDate,
      'name': name,
      'vote_average': voteAverage,
      'vote_count': voteCount,
      'video': video,
      'seasons': seasons,
      'cast': cast, // ✅ إضافة `cast` إلى `toJson()`
    };
  }
}

class TvShowResponse {
  final int page;
  final List<TvShow> results;

  TvShowResponse({
    required this.page,
    required this.results,
  });

  factory TvShowResponse.fromJson(Map<String, dynamic> json) {
    return TvShowResponse(
      page: json['page'] ?? 1,
      results: (json['results'] as List<dynamic>?)
              ?.map((tvShowJson) => TvShow.fromJson(tvShowJson))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'results': results.map((tvShow) => tvShow.toJson()).toList(),
    };
  }
}

class Dates {
  final String maximum;
  final String minimum;

  Dates({
    required this.maximum,
    required this.minimum,
  });

  factory Dates.fromJson(Map<String, dynamic> json) {
    return Dates(
      maximum: json['maximum'] ?? 'N/A',
      minimum: json['minimum'] ?? 'N/A',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'maximum': maximum,
      'minimum': minimum,
    };
  }
}
*/
