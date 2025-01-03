import 'package:filmclick/models/tv_model.dart';
import 'package:filmclick/views/home/header_widget.dart';
import 'package:filmclick/views/home/main_body.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:filmclick/controllers/details_controller.dart';
import 'package:filmclick/models/movie_model.dart';
import 'package:filmclick/services/fetchs_service.dart';
import 'package:filmclick/shared/SideBar.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final MovieService _movieService = MovieService();
  late Future<List<Movie>> _upcomingMoviesFuture;
  late Future<List<Movie>> _popularMoviesFuture;
  late Future<List<TvShow>> _popularTvShowsFuture;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    _upcomingMoviesFuture = _movieService.fetchUpcomingMovies();
    _popularMoviesFuture = _movieService.fetchPopularMovies();
    _popularTvShowsFuture = _movieService.fetchPopularTvShows();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          SizedBox(
            height: 30,
          ),
          Container(color: const Color.fromARGB(255, 11, 16, 47)),
          RefreshIndicator(
            onRefresh: () async {
              setState(() {
                _loadData();
              });
            },
            child: SingleChildScrollView(
              child: MainBody(
                upcomingMoviesFuture: _upcomingMoviesFuture,
                popularMoviesFuture: _popularMoviesFuture,
                popularTvShowsFuture: _popularTvShowsFuture,
              ),
            ),
          ),
          const Positioned(
            top: 40,
            left: 40,
            right: 75,
            child: HeaderWidget(),
          ),
          Positioned(right: -10, child: SideBarContainer()),
        ],
      ),
    );
  }
}
