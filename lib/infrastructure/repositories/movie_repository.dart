import 'package:cinemapedia/domain/datasources/imovie_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/imovie_repository.dart';

class MovieRepository extends IMovieRepository {
  final IMovieDatasource datasource;

  MovieRepository(this.datasource);

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
   return this.datasource.getNowPlaying(page: page);
  }
}
