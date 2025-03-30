//NOTA: LA DIFERENCIA ENTRE REPOSITORY Y LOS DATASOURCE
//ES QE LOS REPOSITORY SON LOS QUE VAN A LLAMAR LOS DATASOURCE
/*POR ESO ES QUE SON CASI IDENTICOS */
//ES POR ESO QUE CUANDO LLAMAMOS A LOS DATASOURCE NO LOS LLAMAMOS DE FORMA DIRECTA
//SI NO QUE LOS LLAMAMOS A TRAVES DE LOS REPOSITORY
//ESTO  ES POR QUE EL REPOSITORY ES EL QUE ME VA A PERMITIR CAMBIAR EL DATASOURCE

//aqui voy a utilizar clases abstractas por que no quiero crear instancias de esta clase
//en este datasource voy a definir como lucen los origenes de datos que pueden traer datos de cualquier dato
//basicamente aqui defino los metodos que voy a utilizar para traer los datos
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/entities/video.dart';

abstract class MoviesRepository {
  //estoy definiendo el metodo que sirve para que me traiga
  //la cartelera que esta disponible para hoy y estoy
  //enviando como parametro que me traiga la primera pagina por que esto va a estar paginado
  //para traer las peliculas que estan en cine
  Future<List<Movie>> getNowPlaying({int page = 1});

  //para traer las proximos estrenos
  Future<List<Movie>> getUpcoming({int page = 1});

  //para traer las peliculas mas populares
  Future<List<Movie>> getPopular({int page = 1});

  //para traer las peliculas mejor calificadas
   Future<List<Movie>> getTopRated({int page = 1});

   //para traer una pelicula por el id
  Future<Movie> getMovieById(String id);

//para buscar la pelicula
  Future<List<Movie>> searchMovies(String query);

  Future<List<Movie>> getSimilarMovies( int movieId );

  Future<List<Video>> getYoutubeVideosById( int movieId );
}
