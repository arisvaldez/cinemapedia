import 'package:cinemapedia/domain/entities/actor.dart';

abstract class IActorDatasource {
  Future<List<Actor>> getActorByMovie(String movieId);
}
