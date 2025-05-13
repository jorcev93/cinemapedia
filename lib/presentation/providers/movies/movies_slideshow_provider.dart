//este va a ser un provider de solo lectura
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/domain/entities/movie.dart';

import 'movies_providers.dart';

//en el porvaider especifico que va a ser una lista de peliculas  
//osea paso de esto "Provider((ref)" a esto "Provider<List<Movie>>((ref)"
//caso contrario el tio de dato que retornara el provider seria un dynamic
final moviesSlideshowProvider = Provider<List<Movie>>((ref){
  //como estoy dentro de provaiders y tengo acceso al ref, esto me permite buscar cualquier provider
  //por lo que busco el provider nowPlayingMovies y lo instancio
  final nowPlayingMovies = ref.watch( nowPlayingMoviesProvider );

  if ( nowPlayingMovies.isEmpty ) return [];//aqui valido si esq el nowPlayingMovies, esta vacio retorno un arreglo vacio
  return nowPlayingMovies.sublist(0,6);//si no esta vacio retorno una sublista de 6 peliculas

});