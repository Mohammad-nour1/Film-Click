/*import 'package:filmclick/controllers/episode_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class EpisodeDetailsPage extends StatelessWidget {
  final int tvShowId;
  final int seasonNumber;
  final int episodeNumber;
  final EpisodeDetailsController controller = Get.put(EpisodeDetailsController());

  EpisodeDetailsPage({required this.tvShowId, required this.seasonNumber, required this.episodeNumber});

  @override
  Widget build(BuildContext context) {
    controller.fetchEpisodeDetails(tvShowId, seasonNumber, episodeNumber);

    return Scaffold(
      appBar: AppBar(title: Text("Episode Details")),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        final details = controller.episodeDetails;
        return details.isEmpty
            ? Center(child: Text("No details available"))
            : Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Episode: ${details['name']}", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text("Air Date: ${details['air_date'] ?? 'N/A'}"),
                    SizedBox(height: 8),
                    Text("Overview: ${details['overview'] ?? 'No description'}"),
                  ],
                ),
              );
      }),
    );
  }
}
*/