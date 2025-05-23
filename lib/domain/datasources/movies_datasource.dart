//NOTA: EN DOMAIN NO HAGO IMPLEMENTACIONES SOLO DFINO COMO VA A LUCIR LOS DATASOURCE
//NOTA: LA DIFERENCIA ENTRE REPOSITORY Y LOS DATASOURCE
//ES QE LOS REPOSITORY SON LOS QUE VAN A LLAMAR LOS DATASOURCE
//*POR ESO ES QUE SON CASI IDENTICOS */

//aqui voy a utilizar clases abstractas por que no quiero crear instancias de esta clase
//en este datasource voy a definir como lucen los origenes de datos que pueden traer datos de cualquier dato
//basicamente aqui defino los metodos que voy a utilizar para traer los datos
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/entities/video.dart';

abstract class MoviesDatasource {
  //estoy definiendo el metodo que sirve para que me traiga
  //la cartelera que esta disponible para hoy y estoy
  //enviando como parametro que me traiga la primera pagina por que esto va a estar paginado

  //peliculas que estan en el cine
  Future<List<Movie>> getNowPlaying({int page = 1});

  //metodo para traer las peliculas upComing(proximamente)
  Future<List<Movie>> getUpcoming({int page = 1});

  //metodo para traer las peliculas ppopulares
  Future<List<Movie>> getPopular({int page = 1});

  //metodo para traer las peliculas upComing(mejor calificadas)
  Future<List<Movie>> getTopRated({int page = 1});

  //metodo para traer una pelicula por el id
  Future<Movie> getMovieById(String id);

  //metodo para la busqueda, se lo puede crear a parte pero como es parte de la pelicula lo voy a colocar aqui
  Future<List<Movie>> searchMovies(String query);

   Future<List<Movie>> getSimilarMovies( int movieId );

  Future<List<Video>> getYoutubeVideosById( int movieId );
}
