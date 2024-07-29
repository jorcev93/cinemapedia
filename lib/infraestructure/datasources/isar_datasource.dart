//AQUI VOY A IMPLEMENTAR LOS METODOS QUE CREE EN EL DOMAIN, QUE VAN A SERVIR PARA
//EL ALMACENAMIENTO LOCAL OSEA DE LAS CLASES local_storage
//y coloco el nombre de la db que voy a utilizar en este caso "isar", si fuera otra db
//pondria el nombre de la misma, pero se lo hace asi para tener en claro que es la db que estoy utilizando
//pero se podira poner cualquier otro nombre

import 'package:cinemapedia/domain/datasources/local_storage_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';

//esta clase va a extender del LocalStorageDatasource, que se ubica en cinemapedia/domain/datasources/local_storage_datasource.dart'
//para solucionar el error luego de crear la lase nos ubicamos sobre IsarDatasource, tecleamos "ctrl + ."
// y seleccionamos create 3 missing override, en este caso son solo ttres por que estos son los 
//metos creados en el datasource
class IsarDatasource extends LocalStorageDatasource {
  @override
  Future<bool> isMovieFavorite(int movieId) {
    // TODO: implement isMovieFavorite
    throw UnimplementedError();
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) {
    // TODO: implement loadMovies
    throw UnimplementedError();
  }

  @override
  Future<void> toggleFavorite(Movie movie) {
    // TODO: implement toggleFavorite
    throw UnimplementedError();
  }
  

}
