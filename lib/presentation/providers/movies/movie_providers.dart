import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nowPlayingMoviesProvider =
    StateNotifierProvider<MovieNotifier, List<Movie>>((ref) {
  final fetchMoreMoviesRef = ref.watch(movieRepositoryProvider).getNowPlaying;
  return MovieNotifier(fetchMoreMovies: fetchMoreMoviesRef);
});

typedef MovieCallback = Future<List<Movie>> Function({int page});

class MovieNotifier extends StateNotifier<List<Movie>> {
  int currentPage = 0;
  MovieCallback fetchMoreMovies;

  MovieNotifier({required this.fetchMoreMovies}) : super([]);

  Future<void> loadNextPage() async {
    currentPage += 1;
    final List<Movie> newMovies = await fetchMoreMovies(page: currentPage);

    state = [...state, ...newMovies];
  }
}
