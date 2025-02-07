/*import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class LiveTVController extends GetxController {
  RxInt selectedChannelIndex = 0.obs;
  late VideoPlayerController videoController;

  final List<Map<String, String>> channels = [
    {"name": "قناة القرآن", "url": "https://www.elahmad.com/tv/qurantv.php"},
    {"name": "قناة السنة", "url": "https://www.elahmad.com/tv/sunnatv.php"},
    {"name": "قناة الإخبارية", "url": "https://www.elahmad.com/tv/ekhbariyatv.php"},
    {"name": "قناة TRT", "url": "https://www.elahmad.com/tv/trtarabic.php"},
  ];

  @override
  void onInit() {
    super.onInit();
    initializePlayer(channels[0]["url"]!);
  }

  void initializePlayer(String url) {
    videoController = VideoPlayerController.networkUrl(Uri.parse(url))
      ..initialize().then((_) {
        videoController.play();
        update();
      });
  }

  void changeChannel(int index) {
    selectedChannelIndex.value = index;
    initializePlayer(channels[index]["url"]!);
  }

  @override
  void onClose() {
    videoController.dispose();
    super.onClose();
  }
}
*/