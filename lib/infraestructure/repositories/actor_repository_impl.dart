//esta implementacion va a llamar el Repository que hace uso del datasource y este va a llamar esos metodos
import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/domain/repositories/actors_repository.dart';

//utilizamos "ctrl + .", para crear el override faltante
class ActorRepositoryImpl extends ActorsRepository {
  final ActorsDatasource datasource;

  ActorRepositoryImpl(
      this.datasource); //mandamos a llamar la clase padre, es decir la clase que va a implementar
  @override
  Future<List<Actor>> getActorsByMovie(String movieId) {
    return datasource.getActorsByMovie(movieId);
  }
}
