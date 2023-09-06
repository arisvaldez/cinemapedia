import 'package:cinemapedia/infrastructure/datasources/moviedb/actor_datasource.dart';
import 'package:cinemapedia/infrastructure/repositories/actor_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorRepositoryProvider =
    Provider((ref) => ActorRepository(ActorDatasource()));
