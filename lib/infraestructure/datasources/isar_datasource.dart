//AQUI VOY A IMPLEMENTAR LOS METODOS QUE CREE EN EL DOMAIN, QUE VAN A SERVIR PARA
//EL ALMACENAMIENTO LOCAL OSEA DE LAS CLASES local_storage
//y coloco el nombre de la db que voy a utilizar en este caso "isar", si fuera otra db
//pondria el nombre de la misma, pero se lo hace asi para tener en claro que es la db que estoy utilizando
//pero se podira poner cualquier otro nombre

import 'package:cinemapedia/domain/datasources/local_storage_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

//esta clase va a extender del LocalStorageDatasource, que se ubica en cinemapedia/domain/datasources/local_storage_datasource.dart'
//para solucionar el error luego de crear la lase nos ubicamos sobre IsarDatasource, tecleamos "ctrl + ."
// y seleccionamos create 3 missing override, en este caso son solo ttres por que estos son los
//metos creados en el datasource
class IsarDatasource extends LocalStorageDatasource {
  //utilizo late por que es una tarea sincrona
  //por lo que antes de ahcer cualquier trabajo o peticion, debeos esperar aq ue la db este lista
  late Future<Isar> db;

  IsarDatasource() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    //validamos si tenemos alguna instancia
    final dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      //el MovieSchema, es el esquema que yo ree con el build
      return await Isar.open([MovieSchema],
          inspector: true, directory: dir.path);
    }
    //si ya la teneos regresamos la instancia
    return Future.value(Isar.getInstance());
  }

  //en este metodo es para saber si en esa base de datos existe una pelicula por ese id
  //ahora si esque queremos trabajar con la base de datos este levantada y que tengamos la instancia
  //por eso declare esto late Future<Isar> db;
  @override
  Future<bool> isMovieFavorite(int movieId) async {
    final isar =
        await db; //con esto estamos esperando a que la db este levantada
    final Movie? isFavoriteMovie =
        await isar.movies.filter().idEqualTo(movieId).findFirst();

    return isFavoriteMovie != null;
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) async {
    //isar va a ser igual al await de la db;
    //esto me sirve para saber si la db esta lista
    final isar = await db;
    return isar.movies
        .where()
        .offset(
            offset) // el offset me sirve para saber los siguientes videos que debo de traer segun el limite establecido
        .limit(limit) //sirve para saber la cantidad maxima de videos debo traer
        .findAll();
  }

  @override
  Future<void> toggleFavorite(Movie movie) async {
    final isar = await db;
    final favoriteMovie =
        await isar.movies.filter().idEqualTo(movie.id).findFirst();

    if (favoriteMovie != null) {
      //borrar
      isar.writeTxnSync(() => isar.movies.deleteSync(favoriteMovie.isarId!));//pongo el signo de interrogacion por que si lo tengo
      return;
    }

    //insertar
    isar.writeTxnSync(() => isar.movies.putSync(movie));
  }
}
