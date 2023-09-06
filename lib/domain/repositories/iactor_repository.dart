import 'package:cinemapedia/domain/entities/actor.dart';

abstract class IActorRepository {
  Future<List<Actor>> getActorByMovie(String movieId);
}
