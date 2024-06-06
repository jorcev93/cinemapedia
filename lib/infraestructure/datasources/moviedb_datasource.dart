//NOTA COMO VOY A UTILIZAR PETICIONES HTTP, VOY A INSTALAR EL PAQUE dio
//dio: es un gestor de peticiones http
//este datasource, es exclusivamente para trabajar y tener las consiideraciones con themoviedb
import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infraestructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infraestructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';

class MoviedbDatasource extends MoviesDatasource {
  //lo defino a nivel de propiedad de la calase para utilizarlo en los diferentes metodos dentro de esta clase
  final dio = Dio(BaseOptions(
      baseUrl:
          'https://api.themoviedb.org/3', //este baseUrl, significa que voy a tener unaurl predefinida
      queryParameters: {
        'api_key': Environment.theMovieDbKey, //obtenemos el api key
        'languaje':
            'es-MX' //definimos el lenguaje que queremos utilizar en nuestra app
      }));
  //aqui se debe implementar lo que el datasource me pide
  //voy a sobreescribir el metodo que cree en MoviesDatasource
  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    //dentro del metodo; Dio("aqui van varias configuraciones globales")
    //se lo podria deinir dentro de este metodo, pero si quiero utilizarlo
    //en diferentes metodos, tendria que volverlo a definir por cada uno de ellos
    //para ello es mejor elevarlo a nivel de propiedad de la clase
    //final dio = Dio();

    //instanciamos el dio
    final response = await dio.get('/movie/now_playing');
    //cuando mando a llamar la data desde el api, tengo que procesarla
    //para ello vamos a utilizar un modelo para leer lo que viene desde moviedb y
    //un maper para que en basado en esa data crear nuestra entidad
    final movieDBResponse =
        MovieDbResponse.fromJson(response.data); //recibimos el json
    //Lo mapeamos y recibimos un listado de movies
    final List<Movie> movies = movieDBResponse.results
        //este where lo utilizo para realizar validaciones, y evitarlas realizar el flutter
        .where((moviedb) =>
            moviedb.posterPath != 'no-poster') //aqui valido si esque es diferente de 'no poster', va a pasar caso contrario no va a mostrar nada
        .map((moviedb) => MovieMapper.movieDBToEntity(moviedb))
        .toList();
    return movies;
  }
}
