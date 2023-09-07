import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/imovie_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_details.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';

class MoviedbDatasource extends IMovieDatasource {
  final dio = Dio(
    BaseOptions(baseUrl: 'https://api.themoviedb.org/3', queryParameters: {
      'api_key': Environment.theMovieDbKey,
      'language': 'es-MX'
    }),
  );

  Future<List<Movie>> _getMovies(
      {required String url, int page = 1, query = ''}) async {
    final response = await dio.get(
      url,
      queryParameters: {'page': page, 'query': query},
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
    return await _getMovies(url: '/movie/now_playing', page: page);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    return await _getMovies(url: '/movie/popular', page: page);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    return await _getMovies(url: '/movie/top_rated', page: page);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    return await _getMovies(url: '/movie/upcoming', page: page);
  }

  @override
  Future<Movie> getMovieById(String id) async {
    final response = await dio.get('/movie/$id');

    if (response.statusCode != 200) {
      throw Exception('Movie With id: $id not found');
    }

    final movieDetails = MovieDetails.fromJson(response.data);
    final Movie movie = MovieMapper.movieDetailsToEntity(movieDetails);

    return movie;
  }

  @override
  Future<List<Movie>> search(String query) async {
    return await _getMovies(url: '/search/movie', query: query);
  }
}
