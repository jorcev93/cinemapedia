//NOTA: SI ES QUE ESTUVIERAMOS TRABAJANDO CON EL GESTOR DE ESTDO PROVIDER
//NO PODRIAMOS CREAR VARIAS INSTANCIAS DEL MISMO PROVIDER QUE SON nowPlayingMoviesProvider, popularMoviesProvider
//PERO COMO ESTAMOS TRABAJANDO CON Riverpod, SI LO PODEMOS HACER, ES MAS PODRIAMOS TENER TODAS LAS INSTANCIAS QUE QUISIERAMOS

import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//este nowPlayingMoviesProvider, me a apermitir saber cuales peliculas estan en el cine
//cuando yo necesite consultar su información
/*Explicacion de StateNotifierProvider */
//significa que es un proveedor de estado que notifica cuando hay un cambio
/*Explicacion de StateNotifierProvider StateNotifierProvider<MoviesNotifier,List<Movie>>*/
//MoviesNotifier: este es la clase que lo controla, o que sirve para notificar
//List<Movie>: esta es la data o state
final nowPlayingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  //se utiliza watch, por que no sabemos si a posterior vamos a cambiar por otro provaider o de mo
  //este fetechMoreMovies, no es la funcion si no el repositoryImpl, de aqui quiero extraer el getNowPlaying
  //esto solo es una referencia a la funcion
  final fetechMoreMovies = ref.watch(movieRepositoryProvider).getNowPlaying;
  return MoviesNotifier(fetchMoreMovies: fetechMoreMovies); //rtorno una isntancia de MoviesNotifier
});

final upcomingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetechMoreMovies = ref.watch(movieRepositoryProvider).getUpcoming;
  return MoviesNotifier(fetchMoreMovies: fetechMoreMovies); //rtorno una isntancia de MoviesNotifier
});

final popularMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetechMoreMovies = ref.watch(movieRepositoryProvider).getPopular;
  return MoviesNotifier(fetchMoreMovies: fetechMoreMovies); //rtorno una isntancia de MoviesNotifier
});

final topRatedMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetechMoreMovies = ref.watch(movieRepositoryProvider).getTopRated;
  return MoviesNotifier(fetchMoreMovies: fetechMoreMovies); //rtorno una isntancia de MoviesNotifier
});


//esto me sirve para especificar el tipo de funcion que espero
//esto me sirve para que el MoviesNotifier, cuando quiera cargar las siguientes peliculas
//va a recibir esta funcion
typedef MovieCallback = Future<List<Movie>> Function({int page});

//el StateNotifier, va a pedir que tipo de estado es el que voy a mantener dentro de el
//en este caso voy a notificar que voy a mantener un listado de movie
//El movie lo immportamos de nuestra capa de dominio
class MoviesNotifier extends StateNotifier<List<Movie>> {
  //este notifier lo estoy creando de manera general por que me va a servir para muchas cosas
  int currentPage = 0; //variable para saber la pagina actual

  MovieCallback fetchMoreMovies;

  MoviesNotifier({required this.fetchMoreMovies}) : super([]);
  //el objetivo de este es hacer una modificacion en el state
  Future<void> loadNextPage() async {
    currentPage++; //cada ves que se llame a loadNextPage, va a incrementar en uno
    final List<Movie> movies = await fetchMoreMovies(page: currentPage);
    state = [
      ...state,
      ...movies
    ]; //aqui utilizamos el orerrador expec para que sea
  }
}
