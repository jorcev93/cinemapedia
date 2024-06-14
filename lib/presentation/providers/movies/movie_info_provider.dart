//este provider me va a servir para almacenar datos en cache
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/domain/entities/movie.dart';

//qui hacemos la implementacion de este provider que es de tipo StateNotifierProvider
final movieInfoProvider = StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>((ref) {
  final movieRepository = ref.watch( movieRepositoryProvider );
  return MovieMapNotifier(getMovie: movieRepository.getMovieById );
});

//asi quiero que funcione el state de este provider
//es decir que voy a definir un map con el id de la pelicula y va a apuntar una instancia de movie
//entonces voy a ir preguntando si esque la pelicula ya se consulto y si esq no se hace una nueva peticion 
/*
  {
    '505642': Movie(),
    '505643': Movie(),
    '505645': Movie(),
    '501231': Movie(),
  }
*/

typedef GetMovieCallback = Future<Movie>Function(String movieId);

class MovieMapNotifier extends StateNotifier<Map<String,Movie>> {

  final GetMovieCallback getMovie;

  //constructor de la clase
  MovieMapNotifier({
    required this.getMovie,
  }): super({});

  //qui mandamos a llamar la implementacion que trae la pelicula
  Future<void> loadMovie( String movieId ) async {
    if ( state[movieId] != null ) return;//si el state tiene una pelicula con ese id entonces ya no voy a regresar nada 
    final movie = await getMovie( movieId );//caso contrario pedymos la pelicula
    state = { ...state, movieId: movie };//actualizamos el estado
  }

}