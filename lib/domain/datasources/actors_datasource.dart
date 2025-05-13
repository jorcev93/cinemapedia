import 'package:cinemapedia/domain/entities/actor.dart';


//esta clase es para manejar los metodos que corresponden a los actores
abstract class ActorsDatasource {

  //trae una lista de actores por el idde la pelicula
  Future<List<Actor>> getActorsByMovie( String movieId );

}