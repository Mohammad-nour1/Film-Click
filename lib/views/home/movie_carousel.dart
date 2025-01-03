import 'package:carousel_slider/carousel_slider.dart';
import 'package:filmclick/views/details_veiw.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:filmclick/controllers/details_controller.dart';
import 'package:filmclick/models/movie_model.dart';

class MovieCarousel extends StatelessWidget {
  final Future<List<Movie>> moviesFuture;
  final String title;

  const MovieCarousel(
      {Key? key, required this.moviesFuture, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 70),
        Text(
          title,
          style: const TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 15),
        FutureBuilder<List<Movie>>(
          future: moviesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final movies = snapshot.data!;
              return CarouselSlider(
                options: CarouselOptions(
                  height: 300,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.8,
                ),
                items: movies.map((movie) {
                  return GestureDetector(
                    onTap: () {
                      Get.put(DetailsController()).setMovie(movie);
                      Get.to(() => DetailsView());
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(19),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.network(
                            'https://image.tmdb.org/t/p/w500${movie.backdropPath}',
                            fit: BoxFit.cover,
                          ),
                          Container(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                movie.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            } else {
              return const Center(child: Text('No movies available.'));
            }
          },
        ),
      ],
    );
  }
}
