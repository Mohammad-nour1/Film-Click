import 'package:filmclick/routes/app_routes.dart';
import 'package:filmclick/shared/SideBar.dart';
import 'package:filmclick/views/details_view.dart';
import 'package:filmclick/views/fav_view.dart';
import 'package:filmclick/views/football_view.dart';
import 'package:filmclick/views/home_view.dart';
import 'package:filmclick/views/landing/landing_view.dart';
import 'package:filmclick/views/movies_view.dart';
import 'package:filmclick/views/home/settings_view.dart';
import 'package:filmclick/views/auth/login_view.dart';
import 'package:filmclick/views/auth/register_view.dart';
import 'package:filmclick/views/splash/splash_view.dart';
import 'package:filmclick/views/tvshows_view.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppPages {
  static final List<GetPage> pages = [
    // الصفحات التي لا تحتوي على الشريط الجانبي
    GetPage(name: AppRoutes.splash, page: () => SplashView()),
    GetPage(name: AppRoutes.login, page: () => LoginView()),
    GetPage(name: AppRoutes.register, page: () => RegisterView()),
    GetPage(name: AppRoutes.landing, page: () => LandingView()),

    // الصفحات التي تحتوي على الشريط الجانبي
    GetPage(
      name: AppRoutes.home,
      page: () => Scaffold(
        body: Stack(
          children: [
            HomeView(),
            Positioned(
              top: 0,
              right: 0,
              bottom: 0,
              child: SideBar(),
            ),
          ],
        ),
      ),
    ),
    GetPage(
      name: AppRoutes.football,
      page: () => Scaffold(
        body: Stack(
          children: [
            FootballView(),
            Positioned(
              top: 0,
              right: 0,
              bottom: 0,
              child: SideBar(),
            ),
          ],
        ),
      ),
    ),
    GetPage(
      name: AppRoutes.favorites,
      page: () => Scaffold(
        body: Stack(
          children: [
            FavoritesView(),
            Positioned(
              top: 0,
              right: 0,
              bottom: 0,
              child: SideBar(),
            ),
          ],
        ),
      ),
    ),
    GetPage(
      name: AppRoutes.settings,
      page: () => Scaffold(
        body: Stack(
          children: [
            SettingsView(),
            Positioned(
              top: 0,
              right: 0,
              bottom: 0,
              child: SideBar(),
            ),
          ],
        ),
      ),
    ),
    GetPage(
      name: AppRoutes.tvshows, // تعديل من home إلى tvshows
      page: () => Scaffold(
        body: Stack(
          children: [
            TvShowsView(),
            Positioned(
              top: 0,
              right: 0,
              bottom: 0,
              child: SideBar(),
            ),
          ],
        ),
      ),
    ),
    GetPage(
      name: AppRoutes.movies, // تعديل من home إلى movies
      page: () => Scaffold(
        body: Stack(
          children: [
            MoviesView(),
            Positioned(
              top: 0,
              right: 0,
              bottom: 0,
              child: SideBar(),
            ),
          ],
        ),
      ),
    ),
    GetPage(
      name: AppRoutes.detailsview, // تعديل من home إلى movies
      page: () => Scaffold(
        body: Stack(
          children: [
            DetailsView(),
            Positioned(
              top: 0,
              right: 0,
              bottom: 0,
              child: SideBar(),
            ),
          ],
        ),
      ),
    ),
  ];
}
