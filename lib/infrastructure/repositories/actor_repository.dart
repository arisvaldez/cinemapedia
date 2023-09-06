import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/domain/repositories/iactor_repository.dart';
import 'package:cinemapedia/infrastructure/datasources/moviedb/actor_datasource.dart';

class ActorRepository extends IActorRepository{
  
  final ActorDatasource datasource;

  ActorRepository(this.datasource);

  @override
  Future<List<Actor>> getActorByMovie(String movieId) async {
    return datasource.getActorByMovie(movieId);

  }

}