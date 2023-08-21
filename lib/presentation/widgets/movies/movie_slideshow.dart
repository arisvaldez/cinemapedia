import 'package:card_swiper/card_swiper.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

class MovieSlideshow extends StatelessWidget {
  final List<Movie> movies;
  const MovieSlideshow({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210,
      width: double.infinity,
      child: Swiper(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie =  movies[index];
          return Text(movie.title);
        },
      ),
    );
  }
}
