import 'package:filmclick/routes/app_routes.dart';
import 'package:filmclick/views/fav_veiw.dart';
import 'package:filmclick/views/football_veiw.dart';
import 'package:filmclick/views/home/home_view.dart';
import 'package:filmclick/views/landing/landing_view.dart';
import 'package:filmclick/views/mainlayout.dart';
import 'package:get/get.dart';
import 'package:filmclick/views/auth/login_view.dart';
import 'package:filmclick/views/auth/register_view.dart';
import 'package:filmclick/views/splash/splash_view.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(name: AppRoutes.splash, page: () => SplashView()),
    GetPage(name: AppRoutes.login, page: () => LoginView()),
    GetPage(name: AppRoutes.register, page: () => RegisterView()),
    GetPage(name: AppRoutes.landing, page: () => LandingView()),

    // صفحات رئيسية مع MainLayout
    GetPage(
      name: AppRoutes.home,
      page: () => MainLayout(content: HomeView()),
    ),

    GetPage(
        name: AppRoutes.football,
        page: () => MainLayout(
              content: FootballView(),
            )),
            GetPage(
        name: AppRoutes.favorites,
        page: () => MainLayout(
              content: FavoritesView(),
            )),

    // GetPage(
    // name: AppRoutes.movies,
    //  page: () => MainLayout(content: MoviesView()),
    //),
    //GetPage(
    //name: AppRoutes.series,
    //page: () => MainLayout(content: SeriesView()),
    //),
    //GetPage(
    //name: AppRoutes.settings,
    //page: () => MainLayout(content: SettingsView()),
    //),
  ];
}
