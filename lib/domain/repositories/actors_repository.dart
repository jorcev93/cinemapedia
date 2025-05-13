import 'package:cinemapedia/domain/entities/actor.dart';

abstract class ActorsRepository {
   //trae una lista de actores por el idde la pelicula
  Future<List<Actor>> getActorsByMovie( String movieId );
}
