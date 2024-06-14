//NOTA COMO VOY A UTILIZAR PETICIONES HTTP, VOY A INSTALAR EL PAQUE dio
//dio: es un gestor de peticiones http
//este datasource, es exclusivamente para trabajar y tener las consiideraciones con themoviedb
import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infraestructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infraestructure/models/moviedb/movie_details.dart';
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

  //Este Metodo es para mandar a llamar las peliculas tanto en getMovieNowPlaying, getPopular
  List<Movie> _jsonToMovies(Map<String, dynamic> json) {
    //cuando mando a llamar la data desde el api, tengo que procesarla
    //para ello vamos a utilizar un modelo para leer lo que viene desde moviedb y
    //un maper para que en basado en esa data crear nuestra entidad
    final movieDBResponse = MovieDbResponse.fromJson(json); //recibimos el json
    //Lo mapeamos y recibimos un listado de movies
    final List<Movie> movies = movieDBResponse.results
        //este where lo utilizo para realizar validaciones, y evitarlas realizar el flutter
        .where((moviedb) =>
            moviedb.posterPath !=
            'no-poster') //aqui valido si esque es diferente de 'no poster', va a pasar caso contrario no va a mostrar nada
        .map((moviedb) => MovieMapper.movieDBToEntity(moviedb))
        .toList();
    return movies;
  }

  //aqui se debe implementar lo que el datasource me pide
  //voy a sobreescribir el metodo que cree en MoviesDatasource
  @override //para traer las peliculas que estan en el cine
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    //dentro del metodo; Dio("aqui van varias configuraciones globales")
    //se lo podria deinir dentro de este metodo, pero si quiero utilizarlo
    //en diferentes metodos, tendria que volverlo a definir por cada uno de ellos
    //para ello es mejor elevarlo a nivel de propiedad de la clase
    //final dio = Dio();

    //instanciamos el dio
    final response = await dio.get('/movie/now_playing',
        //este queryParameters, hago que la pagina vaya cambiando(es decir que se muestren nuevas peliculas cuando llegue al final en sroll horizontal)
        queryParameters: {'page': page});
    return _jsonToMovies(response.data);
    /*Este es lo mismo que en el getPopular por lo que voy a crear un metodo a parte*/
    /*
    //cuando mando a llamar la data desde el api, tengo que procesarla
    //para ello vamos a utilizar un modelo para leer lo que viene desde moviedb y
    //un maper para que en basado en esa data crear nuestra entidad
    final movieDBResponse =
        MovieDbResponse.fromJson(response.data); //recibimos el json
    //Lo mapeamos y recibimos un listado de movies
    final List<Movie> movies = movieDBResponse.results
        //este where lo utilizo para realizar validaciones, y evitarlas realizar el flutter
        .where((moviedb) =>
            moviedb.posterPath !=
            'no-poster') //aqui valido si esque es diferente de 'no poster', va a pasar caso contrario no va a mostrar nada
        .map((moviedb) => MovieMapper.movieDBToEntity(moviedb))
        .toList();
    return movies;*/
  }

  @override //peliculas que estan en proximamente
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    //dentro del metodo; Dio("aqui van varias configuraciones globales")
    //se lo podria deinir dentro de este metodo, pero si quiero utilizarlo
    //en diferentes metodos, tendria que volverlo a definir por cada uno de ellos
    //para ello es mejor elevarlo a nivel de propiedad de la clase
    //final dio = Dio();

    //instanciamos el dio
    final response = await dio.get('/movie/upcoming',
        //este queryParameters, hago que la pagina vaya cambiando(es decir que se muestren nuevas peliculas cuando llegue al final en sroll horizontal)
        queryParameters: {'page': page});
    return _jsonToMovies(response.data);
    /*Este es lo mismo que en el getNowPlaying y que todos los demas metodos por lo que voy a crear un metodo a parte*/
    /*
    //cuando mando a llamar la data desde el api, tengo que procesarla
    //para ello vamos a utilizar un modelo para leer lo que viene desde moviedb y
    //un maper para que  basado en esa data crear nuestra entidad
    final movieDBResponse =
        MovieDbResponse.fromJson(response.data); //recibimos el json
    //Lo mapeamos y recibimos un listado de movies
    final List<Movie> movies = movieDBResponse.results
        //este where lo utilizo para realizar validaciones, y evitarlas realizar el flutter
        .where((moviedb) =>
            moviedb.posterPath !=
            'no-poster') //aqui valido si esque es diferente de 'no poster', va a pasar caso contrario no va a mostrar nada
        .map((moviedb) => MovieMapper.movieDBToEntity(moviedb))
        .toList();
    return movies;*/
  }

  @override //peliculas que son populares
  Future<List<Movie>> getPopular({int page = 1}) async {
    //dentro del metodo; Dio("aqui van varias configuraciones globales")
    //se lo podria deinir dentro de este metodo, pero si quiero utilizarlo
    //en diferentes metodos, tendria que volverlo a definir por cada uno de ellos
    //para ello es mejor elevarlo a nivel de propiedad de la clase
    //final dio = Dio();

    //instanciamos el dio
    final response = await dio.get('/movie/popular',
        //este queryParameters, hago que la pagina vaya cambiando(es decir que se muestren nuevas peliculas cuando llegue al final en sroll horizontal)
        queryParameters: {'page': page});
    return _jsonToMovies(response.data);
    /*Este es lo mismo que en el getNowPlaying por lo que voy a crear un metodo a parte*/
    /*
    //cuando mando a llamar la data desde el api, tengo que procesarla
    //para ello vamos a utilizar un modelo para leer lo que viene desde moviedb y
    //un maper para que  basado en esa data crear nuestra entidad
    final movieDBResponse =
        MovieDbResponse.fromJson(response.data); //recibimos el json
    //Lo mapeamos y recibimos un listado de movies
    final List<Movie> movies = movieDBResponse.results
        //este where lo utilizo para realizar validaciones, y evitarlas realizar el flutter
        .where((moviedb) =>
            moviedb.posterPath !=
            'no-poster') //aqui valido si esque es diferente de 'no poster', va a pasar caso contrario no va a mostrar nada
        .map((moviedb) => MovieMapper.movieDBToEntity(moviedb))
        .toList();
    return movies;*/
  }

  @override //peliculas mejor calificadas
  Future<List<Movie>> getTopRated({int page = 1}) async {
    //dentro del metodo; Dio("aqui van varias configuraciones globales")
    //se lo podria deinir dentro de este metodo, pero si quiero utilizarlo
    //en diferentes metodos, tendria que volverlo a definir por cada uno de ellos
    //para ello es mejor elevarlo a nivel de propiedad de la clase
    //final dio = Dio();

    //instanciamos el dio
    final response = await dio.get('/movie/top_rated',
        //este queryParameters, hago que la pagina vaya cambiando(es decir que se muestren nuevas peliculas cuando llegue al final en sroll horizontal)
        queryParameters: {'page': page});
    return _jsonToMovies(response.data);
    /*Este es lo mismo que en el getNowPlaying por lo que voy a crear un metodo a parte*/
    /*
    //cuando mando a llamar la data desde el api, tengo que procesarla
    //para ello vamos a utilizar un modelo para leer lo que viene desde moviedb y
    //un maper para que  basado en esa data crear nuestra entidad
    final movieDBResponse =
        MovieDbResponse.fromJson(response.data); //recibimos el json
    //Lo mapeamos y recibimos un listado de movies
    final List<Movie> movies = movieDBResponse.results
        //este where lo utilizo para realizar validaciones, y evitarlas realizar el flutter
        .where((moviedb) =>
            moviedb.posterPath !=
            'no-poster') //aqui valido si esque es diferente de 'no poster', va a pasar caso contrario no va a mostrar nada
        .map((moviedb) => MovieMapper.movieDBToEntity(moviedb))
        .toList();
    return movies;*/
  }

  @override
  Future<Movie> getMovieById(String id) async {
    final response = await dio.get('/movie/$id');
    if (response.statusCode != 200)
      throw Exception(
          'Movie with id: $id not found'); //valido si esque existe el id de la pelicula

    final movieDB = MovieDetails.fromJson(response.data);
    
    return movie;
  }
}
