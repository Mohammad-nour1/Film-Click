import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LiveTVController extends GetxController {
  var selectedChannel = ''.obs;
  late YoutubePlayerController youtubeController;

  void setChannel(String url) {
    final videoId = YoutubePlayer.convertUrlToId(url);
    if (videoId != null) {
      youtubeController.load(videoId);
      selectedChannel.value = url;
    }
  }

  @override
  void onInit() {
    super.onInit();
    youtubeController = YoutubePlayerController(
      initialVideoId: '',
      flags: YoutubePlayerFlags(autoPlay: true, mute: false),
    );
  }

  @override
  void onClose() {
    youtubeController.dispose();
    super.onClose();
  }
}

class LivetvView extends StatelessWidget {
  final LiveTVController controller = Get.put(LiveTVController());

  final List<Map<String, String>> channels = [
    {
      'name': 'تلفزيون سوريا',
      'url': 'https://www.youtube.com/watch?v=OLWU0rKOQ6o'
    },
    {
      'name': 'قناة القرآن الكريم',
      'url': 'https://www.youtube.com/watch?v=zVKbxaOFMys'
    },
    {
      'name': 'قناة السنة النبوية',
      'url': 'https://www.youtube.com/watch?v=7qgpaHdmumo'
    },
    {
      'name': ' الجزيرة مباشر ',
      'url': 'https://www.youtube.com/watch?v=bNyUyrR0PHo'
    },
    {'name': ' سكاي نيوز مباشر', 'url': 'https://youtu.be/5uFOH3ZLykw'},
    {'name': ' العربية مباشر', 'url': 'https://youtu.be/n7eQejkXbnM'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 11, 16, 47),
      appBar: AppBar(
        title: Text('البث المباشر', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 11, 16, 47),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Get.toNamed("/home");
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Obx(() {
              if (controller.selectedChannel.value.isEmpty) {
                return Center(
                  child: Text(
                    'اختر قناة للمشاهدة',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                );
              }
              return YoutubePlayer(
                controller: controller.youtubeController,
                showVideoProgressIndicator: true,
              );
            }),
          ),
          Divider(color: Colors.white),
          Expanded(
            flex: 1,
            child: ListView.builder(
              itemCount: channels.length,
              itemBuilder: (context, index) {
                final isSelected =
                    controller.selectedChannel.value == channels[index]['url'];
                return GestureDetector(
                  onTap: () => controller.setChannel(channels[index]['url']!),
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.blueAccent.withOpacity(0.3)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 15),
                      title: Text(
                        channels[index]['name']!,
                        style: TextStyle(
                          color: isSelected ? Colors.blueAccent : Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      tileColor: Colors.transparent,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
