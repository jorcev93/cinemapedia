import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  static const name =
      'home-screen'; //nombre de la ruta que va autilizar go_router para esta pantalla
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // al utilizar las variables de entorno, el scaffold no puede ser constante por que va a cambiar en ejecucion
      body: _HomeView(),
      bottomNavigationBar:
          CustomBottomNavigation(), //mandamos a llamar el menu de navegacion que se muestra en la parte inferior
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
  //aqui lanzamos las eticiones
  @override
  void initState() {
    super.initState();
    ref
        .read(nowPlayingMoviesProvider.notifier)
        .loadNextPage(); //con esto solo mandamos a llamar la data
    ref
        .read(upcomingMoviesProvider.notifier)
        .loadNextPage(); //llamamos el listado de peliculas proximamente
    ref
        .read(popularMoviesProvider.notifier)
        .loadNextPage(); //llamamos el listado de peliculas populares
    ref
        .read(topRatedMoviesProvider.notifier)
        .loadNextPage(); //llamamos las peliculas mejor calificadas
  }

  @override
  Widget build(BuildContext context) {
    //aqui vamos a renderizar la data, es decir vamos a poder ver la data en la pantalla
    final nowPlayingMovies = ref.watch(
        nowPlayingMoviesProvider); //este va a ser el listado de peliculas
    final slideShowMovies = ref.watch(
        moviesSlideshowProvider); //este provaider lo utilizamos para mostrar una subista de 6 peliculas
    final popularMovies = ref.watch(popularMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);

    return FullScreenLoader();

    //el "SingleChildScrollView" me sirve para mostrar varios "MovieHorizontalListview"
    //para que el appbar se mueva justo cuando estoy ahciendo scroll, debo utilizar "CustomScrollView" en lugar de "SingleChildScrollView"
    return CustomScrollView(
        //el sliver, es un widget que trabaja directamente con el scrolleView
        slivers: [
          //esto es para mostrar el appbar
          const SliverAppBar(
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
                titlePadding: EdgeInsets.all(
                    0), //esto es para que el appbar no se quede centrado
                title: CustomAppbar()),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
            return Column(
              children: [
                //const CustomAppbar(),//este app bar ya no va a pertenercer a la colum si no al slivers
                MoviesSlideshow(movies: slideShowMovies),

                //mostrar peliculas en cines
                MovieHorizontalListview(
                  movies: nowPlayingMovies,
                  title: 'En cines',
                  subtitle: 'Lunes 20',
                  loadNextPage: () => ref
                      .read(nowPlayingMoviesProvider.notifier)
                      .loadNextPage(),
                ),

                //mostrar peliculas proximamente
                MovieHorizontalListview(
                  movies: upcomingMovies,
                  title: 'Proximamente',
                  subtitle: 'En este mes',
                  loadNextPage: () =>
                      ref.read(upcomingMoviesProvider.notifier).loadNextPage(),
                ),

                //mostrar peliculas populares
                MovieHorizontalListview(
                  movies: popularMovies,
                  title: 'Populares',
                  //subtitle: 'Lunes 20',
                  loadNextPage: () =>
                      ref.read(popularMoviesProvider.notifier).loadNextPage(),
                ),

                //mostrar peliculas mejor calificadas
                MovieHorizontalListview(
                  movies: topRatedMovies,
                  title: 'Mejor calificadas',
                  //subtitle: 'Desdesiempre',
                  loadNextPage: () =>
                      ref.read(topRatedMoviesProvider.notifier).loadNextPage(),
                ),
                const SizedBox(height: 10)
              ],
            );
          }, childCount: 1))
        ]);
    /*Este expanden ya lo puedo comentar solo lo utilice para saber que si se mostraban las peliculas */
    /*return Column(
      children: [
        const CustomAppbar(),//mando a llamar el widget que cree en la carpeta widgets
        //cuando utilizo colum tambien tengo que utilizar Expanded, para que no se vaya hasta el infinito
        //el expanden hace que dado el padre(Clolumn), ocupe tiodo el espacio posible, 
        //por que este ya tiene un alto y ancho fijo, cabe mencionar que hay algunos widgets que hacen algo similar
        Expanded(
          child: ListView.builder(
            itemCount: nowPlayingMovies.length,
            itemBuilder: (context, index) {
              final movie = nowPlayingMovies[index];
              return ListTile(
                title: Text(movie.title),
              );
            },
          ),
        )
      ],
    );*/
  }
}
