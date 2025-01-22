import 'package:get/get.dart';

class CastService extends GetxController {
  var cast = <Map<String, dynamic>>[].obs;

  void updateCast(List<Map<String, dynamic>> newCast) {
    cast.value = newCast;
  }
}
