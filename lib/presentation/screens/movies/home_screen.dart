import 'package:cinemapedia/presentation/providers/movies/movies_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  static const name =
      'home-screen'; //nombre de la ruta que va autilizar go_router para esta pantalla
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // al utilizar las variables de entorno, el scaffold no puede ser constante por que va a cambiar en ejecucion
      body: _HomeView(),
      /*esto era una prueba, para ver como utilizar las variables de entornno
      body: Center(
        //child: Text(dotenv.env['THE_MOVIEDB_KEY']??'No hay api key'),//asi seria si no utilizo una clase a parte
        child: Text(Environment.theMovieDbKey),//aqui utilio una clase a parte para tener acceso a todas las variables de entorno ms facilmente
      ),*/
    );
  }
}

//con este _HomeView lo que pretendo es que cuando la app se cargue, mande a llamar a la primera pagina
class _HomeView extends ConsumerStatefulWidget {
  //convertimos el StatelessWidget, a un StatefulWidget, y finalmente lo cambiamos a un ConsumerStatefulWidget
  const _HomeView();

  @override
  //esto cambiaria: State<_HomeView> createState() => _HomeViewState();
  //por lo siguiente
  _HomeViewState createState() =>
      _HomeViewState(); //ESTO VENDRIA A SER UNA INSTANCIA DE LA CALSE _HomeViewState
}

class _HomeViewState extends ConsumerState<_HomeView> {
  //aqui en lugar de State va a ser un ConsumerState, esto por que transformamos el StatefulWidget a  ConsumerStatefulWidget

  //este init es propo de un statefullwiget
  @override
  void initState() {
    super.initState();
    ref
        .read(nowPlayingMoviesProvider.notifier)
        .loadNextPage(); //con esto solo mandamos a llamar la data
  }

  @override
  Widget build(BuildContext context) {
    //aqui vamos a renderizar la data, es decir vamos a poder ver la data en la pantalla
    final nowPlayingMovies = ref
        .watch(nowPlayingMoviesProvider); //este va a ser el listado de peliclas
    return ListView.builder(
      itemCount: nowPlayingMovies.length,
      itemBuilder: (context, index) {
        final movie = nowPlayingMovies[index];
        return ListTile(
          title: Text(movie.title),
        );
      },
    );
  }
}
