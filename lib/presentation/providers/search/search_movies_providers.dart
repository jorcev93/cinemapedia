import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//este es para mantener el estado de lo que se escribio anteriormente
final searchQueryProvider = StateProvider<String>((ref) => '');
//final searchedMoviesProvider = StateNotifierProvider<notifier, state>((ref) => null);
final searchedMoviesProvider =
    StateNotifierProvider<SearchedMoviesNotifier, List<Movie>>((ref) {
  final movieRepository = ref.read(movieRepositoryProvider);
  return SearchedMoviesNotifier(
      searchMovies: movieRepository.searchMovies, ref: ref);
});

typedef SearchMoviesCallback = Future<List<Movie>> Function(
    String query); //funcion perzonalizada para recibir el query

//este es el provder va a ctualizar directamente el estado de lo que se escribio
class SearchedMoviesNotifier extends StateNotifier<List<Movie>> {
  final SearchMoviesCallback searchMovies;
  final Ref ref; //esto me sirve para proporcinar la referencia al widget ref
  SearchedMoviesNotifier({required this.ref, required this.searchMovies})
      : super([]);//inicializa el estado en una lista vacia
  Future<List<Movie>> searchMoviesByQuery(String query) async {
    final List<Movie> movies = await searchMovies(query);
    ref.read(searchQueryProvider.notifier).update((state) => query);
    state = movies;
    return movies;
  }
}
