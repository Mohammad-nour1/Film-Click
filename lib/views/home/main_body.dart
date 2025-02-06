import 'package:filmclick/models/movie_model.dart';
import 'package:filmclick/controllers/home_controller.dart';
import 'package:filmclick/views/home/horizontal_movies.dart';
import 'package:filmclick/views/home/horizontal_shows.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'movie_carousel.dart';

class MainBody extends StatelessWidget {
  final HomeController homeController = Get.find();

  MainBody({Key? key, required Future<RxList<Movie>> upcomingMoviesFuture, required Future<RxList<Movie>> popularMoviesFuture, required Future<RxList<TvShow>> popularTvShowsFuture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (homeController.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }
      return Column(
        children: [
          SizedBox(height: 55),
          // شريط الأفلام القادمة
          MovieCarousel(
            moviesFuture: Future.value(homeController.upcomingMovies),
            title: 'أفلام مميزة',
          ),
          const SizedBox(height: 20),

          // قائمة الأفلام الشائعة
          HorizontalMovieListForMovies(
            moviesFuture: Future.value(homeController.movies),
            title: 'أفلام شائعة',
          ),
          const SizedBox(height: 20),

          // قائمة المسلسلات الشائعة
          HorizontalMovieListForTvShows(
            tvShowsFuture: Future.value(homeController.tvShows),
            title: 'مسلسلات شائعة', 
          ),
          const SizedBox(height: 20),

          SizedBox(height: 50),
        ],
      );
    });
  }
}
