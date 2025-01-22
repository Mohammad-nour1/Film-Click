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
        SizedBox(
          height: 55,
        ),
        MovieCarousel(
          moviesFuture: upcomingMoviesFuture,
          title: 'أفلام مميزة',
        ),
        const SizedBox(height: 20),
        HorizontalMovieList(
          itemsFuture: popularMoviesFuture,
          title: 'أفلام شائعة ',
          isMovie: true,
        ),
        const SizedBox(height: 20),
        HorizontalMovieList(
          itemsFuture: popularTvShowsFuture,
          title: 'مسلسلات شائعة',
          isMovie: false,
        ),
        SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 50,
        )
      ],
    );
  }
}
