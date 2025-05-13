//CUALQUIER DATA SOURCE DEBE IMPLEMENTAR ESTOS TRES METODOS
import '../entities/movie.dart';

abstract class LocalStorageDatasource {
  //con esto obtego toda la informacion necesaria de la pelicula, para agregarla o mabiarla si es un favorito o no
  Future<void> toggleFavorite(Movie movie);

  //ára saber si la pelicula esta en mis favoritos a traves del id
  Future<bool> isMovieFavorite(int movieId);

  //Esta es una lista de movies y va a tener un par de argumentos para hacer la paginación
  //limit va a servir para que se muestren de 10 en 10 peliculas
  //el offser va ha servit para la paginación
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0});
}
