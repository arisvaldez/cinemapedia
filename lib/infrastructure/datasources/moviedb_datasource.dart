import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/imovie_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';

class MoviedbDatasource extends IMovieDatasource {
  final dio = Dio(
    BaseOptions(baseUrl: 'https://api.themoviedb.org/3', queryParameters: {
      'api_key': Environment.theMovieDbKey,
      'languaje': 'es-MX'
    }),
  );

  Future<List<Movie>> _getMovies({required String url, int page = 1}) async {
    final response = await dio.get(
      url,
      queryParameters: {'page': page},
    );

    final movieDBResponse = MovieDBResponse.fromJson(response.data);

    final List<Movie> movies = movieDBResponse.results
        .where((movieDB) => movieDB.posterPath != 'no-poster')
        .map((movieDB) => MovieMapper.movieDbToEntity(movieDB))
        .toList();

    return movies;
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    return _getMovies(url: '/movie/now_playing', page: page);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    return _getMovies(url: '/movie/popular', page: page);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) {
    return _getMovies(url: '/movie/top_rated', page: page);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) {
    return _getMovies(url: '/movie/upcoming', page: page);
  }
}
