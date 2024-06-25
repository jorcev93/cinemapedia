//este provider me va a servir para almacenar datos en cache
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/presentation/providers/actors/actors_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//qui hacemos la implementacion de este provider que es de tipo StateNotifierProvider
final actorsByMovieProvider = StateNotifierProvider<ActorsByMovieMapNotifier, Map<String, List<Actor>>>((ref) {
  final actorsRepository = ref.watch( actorsRepositoryProvider );
  return ActorsByMovieMapNotifier(getActors: actorsRepository.getActorsByMovie);
});

//asi quiero que funcione el state de este provider
//es decir que voy a definir un map con el id de la pelicula y va a apuntar una instancia de actor
//entonces voy a ir preguntando si esque la pelicula ya se consulto y si esq no se hace una nueva peticion
/*
  {
    '505642': List<Actor>,
    '505643': List<Actor>,
    '505645': List<Actor>(),
    '501231': List<Actor>(),
  }
*/

typedef GetActorsCallback = Future<List<Actor>>Function(String movieId);

class ActorsByMovieMapNotifier extends StateNotifier<Map<String,List<Actor>>> {
  final GetActorsCallback getActors;

  //constructor de la clase
  ActorsByMovieMapNotifier({
    required this.getActors,
  }) : super({});//asi lo estamos inicializando commo un mapa vacio

  //con esto vamos a tener la pelicula en la cache de la memoria
  //qui mandamos a llamar la implementacion que trae la pelicula
  Future<void> loadActors(String movieId) async {
    if (state[movieId] != null) return; //si el state tiene una pelicula con ese id entonces ya no voy a regresar nadaprint('realizando una peticion http')
    final actors = await getActors(movieId); //caso contrario pedymos la pelicula
    state = {...state, movieId: actors}; //actualizamos el estado
  }
}
