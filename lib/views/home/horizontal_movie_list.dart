import 'package:filmclick/views/details_veiw.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:filmclick/controllers/details_controller.dart';
import 'package:filmclick/models/movie_model.dart';

class HorizontalMovieList extends StatelessWidget {
  final Future<List<dynamic>> itemsFuture;
  final String title;
  final bool isMovie;

  const HorizontalMovieList({
    Key? key,
    required this.itemsFuture,
    required this.title,
    this.isMovie = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            title,
            style: TextStyle(
              fontFamily: 'CooperArabic', // الخط العربي المستخدم
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        SizedBox(
          height: 200,
          child: FutureBuilder<List<dynamic>>(
            future: itemsFuture,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final items = snapshot.data!;
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return GestureDetector(
                    onTap: () {
                      if (isMovie) {
                        Get.put(DetailsController()).setMovie(item);
                      } else {
                        Get.put(DetailsController()).setTvShow(item);
                      }
                      Get.to(() => DetailsView());
                    },
                    child: Container(
                      width: 150,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(13),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(
                              "https://image.tmdb.org/t/p/original/${isMovie ? item.backdropPath : item.backdropPath}",
                              fit: BoxFit.cover,
                            ),
                            Container(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  isMovie ? item.title : item.name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w900,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
