import 'package:filmclick/routes/app_routes.dart';
import 'package:filmclick/views/home/home_view.dart';
import 'package:filmclick/views/landing/landing_view.dart';
import 'package:get/get.dart';
import 'package:filmclick/views/auth/login_view.dart';
import 'package:filmclick/views/auth/register_view.dart';
import 'package:filmclick/views/splash/splash_view.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(name: AppRoutes.landing, page: () => LandingView()),
    GetPage(name: AppRoutes.splash, page: () => SplashView()),
    GetPage(name: AppRoutes.login, page: () => LoginView()),
    GetPage(name: AppRoutes.register, page: () => RegisterView()),
    GetPage(name: AppRoutes.home, page: () => HomeView()),
  ];
}
