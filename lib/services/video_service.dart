import 'package:get/get.dart';

class VideoService extends GetxController {
  var trailerVideoKey = ''.obs;
  var mainVideoKey = ''.obs;

  // دالة لتحديث مفاتيح الفيديو
  void updateVideoKeys(List<Map<String, dynamic>> videos) {
    trailerVideoKey.value = videos.firstWhere(
      (video) => video['type'] == 'Trailer',
      orElse: () => {'key': ''},
    )['key'];

    mainVideoKey.value = videos.firstWhere(
      (video) => video['type'] == 'Teaser',
      orElse: () => {'key': ''},
    )['key'];
  }
}
