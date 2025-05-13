import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infraestructure/mappers/actor_mapper.dart';
import 'package:cinemapedia/infraestructure/models/moviedb/credits_response.dart';
import 'package:dio/dio.dart';

import '../../config/constants/environment.dart';

class ActorMovieDbDatasource extends ActorsDatasource {
  //lo defino a nivel de propiedad de la calase para utilizarlo en los diferentes metodos dentro de esta clase
  final dio = Dio(BaseOptions(
      //este baseUrl, significa que voy a tener una url predefinida,
      //en este caso en la url envio el id que recibe mi metodo
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.theMovieDbKey,
        'languaje': 'es-MX'
      }));
  
  /*
  //Este Metodo es para mandar a llamar las actores de las peliculas
  List<Actor> _jsonActoresToMovie(Map<String, dynamic> json) {
    //cuando mando a llamar la data desde el api, tengo que procesarla
    //para ello vamos a utilizar un modelo para leer lo que viene desde moviedb y
    //un maper para que basado en esa data crear nuestra entidad
    final castResponse = CreditsResponse.fromJson(json); //recibimos el json
    //Lo mapeamos y recibimos un listado de los actores
    final List<Actor> actores = castResponse.cast
        //este where lo utilizo para realizar validaciones, y evitarlas realizar el flutter
        .where((actordb) => actordb.profilePath !='no-poster') //aqui valido si esque es diferente de 'no poster', va a pasar caso contrario no va a mostrar nada
        .map((actordb) => ActorMapper.castToEntity(actordb))
        .toList();
    return actores;
  }
 */
  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {//este metodo recibe el id de la pelicula
    //aqui vamos a realizar la peticion al api de moviedb
    final response = await dio.get('/movie/$movieId/credits');
    final castResponse = CreditsResponse.fromJson(response.data);//aqui recibimos la data
    //aqui mapeamos la data y la retornamos
    List<Actor> actors = castResponse.cast.map(
      (cast) => ActorMapper.castToEntity(cast)
    ).toList();
    return actors;
  }
}
