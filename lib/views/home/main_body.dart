import 'package:filmclick/models/movie_model.dart';
import 'package:filmclick/models/tv_model.dart';
import 'package:flutter/material.dart';
import 'movie_carousel.dart';
import 'horizontal_movie_list.dart';

class MainBody extends StatelessWidget {
  final Future<List<Movie>> upcomingMoviesFuture;
  final Future<List<Movie>> popularMoviesFuture;
  final Future<List<TvShow>> popularTvShowsFuture;

  const MainBody({
    Key? key,
    required this.upcomingMoviesFuture,
    required this.popularMoviesFuture,
    required this.popularTvShowsFuture,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MovieCarousel(
          moviesFuture: upcomingMoviesFuture,
          title: 'Upcoming Movies',
        ),
        const SizedBox(height: 20),
        HorizontalMovieList(
          itemsFuture: popularMoviesFuture,
          title: 'Popular Movies',
          isMovie: true,
        ),
        const SizedBox(height: 20),
        HorizontalMovieList(
          itemsFuture: popularTvShowsFuture,
          title: 'Popular TV Shows',
          isMovie: false,
        ),
      ],
    );
  }
}
