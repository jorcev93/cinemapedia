//NOTA: EL SCOPE, ES TODA LA CLASE DE ESTADO

//NOTA: COMO ESTAMOS UTILIZANDO EL ConsumerState el ref PODEMOS UTILIZARLO DIRECTAMENTE EN EL initState
//POR EL CONTRARIO SI LO ESTUVIÉRAMOS UTILIZANDO EN EL StatefulWidget, LO UTILIZRIOAMOS EN EL build

//NOTA: SE UTILIZA ref.read, cuando estamos en metodos que no se pueden redibujar,
// por ejemplo en callback, ontap, onpress, en el init...

//Esta pantalla va a ser para presentar los datos de una sola pelicula

//el StatefulWidget, me sirve para saber cuando cargo o estoy cargando entre otras cosas, utilizando el inisState

//Nota: los import primero se colocan las importaciones de terceros y luego nuestras importaciones
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:animate_do/animate_do.dart';

import '../../../domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';

//vamos a cambiar el StatefulWidget por un ConsumerStatefulWidget, para poder teer acceso al scope de de nuestro provider
class MovieScreen extends ConsumerStatefulWidget {
  static const name = 'movie-screen';
  final String movieId;
  const MovieScreen({super.key, required this.movieId});

  //como ya cambiamos el State por un ConsumerState y solo tenemos que llamar al metodo
  //State<MovieScreen> createState() => _MovieScreenState();
  @override
  MovieScreenState createState() => MovieScreenState();
}

//como cambiamos el StatefulWidget por un ConsumerStatefulWidget, tambien debemos cambiar el State, por un ConsumerState
class MovieScreenState extends ConsumerState<MovieScreen> {
  //me sirve para manejar un cache local, para efientizar y no estar haceindo una nueva peticion si esq ya la hicimos anterormente
  @override
  void initState() {
    super.initState();
    //esto realiza la peticion http, para traer los datos de la peli por el id
    ref.read(movieInfoProvider.notifier).loadMovie(widget
        .movieId); //se utiliza widget antes de movieID, por qe estamos dentro del initstate
    ref.read(actorsByMovieProvider.notifier).loadActors(widget
        .movieId); //se utiliza widget antes de movieID, por qe estamos dentro del initstate
  }

  @override
  Widget build(BuildContext context) {
    final Movie? movie = ref.watch(movieInfoProvider)[widget.movieId];
    //validamos si es que existe la pelicula
    if (movie == null) {
      return const Scaffold(
          body: Center(child: CircularProgressIndicator(strokeWidth: 2)));
    }
    return Scaffold(
      //voy a tulizar el CustomScrollView, por que voy a emplear los slivers
      body: CustomScrollView(
        physics:
            const ClampingScrollPhysics(), //esto es para quitar el efecto rebote que sabe tener en ios
        slivers: [
          _CustomSliverAppBar(movie: movie),
          SliverList(
              delegate: SliverChildBuilderDelegate(
                  (context, index) => _MovieDetails(movie: movie),
                  childCount: 1))
        ],
      ),
    );
  }
}

class _CustomSliverAppBar extends ConsumerWidget {
  final Movie movie;
  const _CustomSliverAppBar({required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size =
        MediaQuery.of(context).size; //con esto se el tamaño del dipositivo
    //aqui vamos a empezar a construir un appbar perzonalizado
    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height *
          0.7, //aqui estoy diciendo que va a tomar el 70% de la pantalla
      foregroundColor: Colors.white,
      actions: [
        IconButton(
            onPressed: () {
              //realizar el toggle, para eso buscamos el provider
              ref.watch(localStorageRepositoryProvider).toggleFavorite(movie);
            },
            icon: Icon(Icons.favorite_border)
            //icon: Icon(Icons.favorite_rounded, color: Colors.red,),
            )
      ],
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        /* title: Text(
          movie.title,
          style: const TextStyle(fontSize: 20),
          textAlign: TextAlign.start,
        ), */
        //el stack me permite colocar widgets unos sobre ottros
        background: Stack(
          children: [
            SizedBox.expand(
              //el expanded es para que tome todo el espacio posible del padre
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) return const SizedBox();
                  return FadeIn(child: child);
                },
              ),
            ),

            /*Gradiente para favoritos */
            //gradiente utilizando codigo reutilizable
            const _CustomGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                stops: [0.0, 0.2],
                colors: [Colors.black54, Colors.transparent]),

            //sin reutilizar codigo
            /*
            const SizedBox.expand(
              child: DecoratedBox(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          //aqui defino la posicion del gradiente, en este caso es de abajo hacia arriba
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          stops: [
                    0.0,
                    0.2
                  ], //aqui defino donde empieza que seria en el 70% de la pantalla y luego llega hasta el 10%
                          colors: [
                    Colors.black54,
                    Colors.transparent
                  ]))),
            ),*/

            /*Gradiente para la imagen del poster */
            //gradiente utilizando codigo reutilizable
            const _CustomGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.8, 1.0],
                colors: [Colors.transparent, Colors.black54]),

            //sin codigo reutilizable
            /*const SizedBox.expand(
              child: DecoratedBox(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          //aqui defino la posicion del gradiente, en este caso es de abajo hacia arriba
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [
                    0.7,
                    1.0
                  ], //aqui defino donde empieza que seria en el 70% de la pantalla y luego llega hasta el 10%
                          colors: [
                    Colors.transparent,
                    Colors.black87
                  ]))),
            ),*/

            /*Gradiante para la flecha */
            //con codigo reutilizable
            //gradiente utilizando codigo reutilizable
            const _CustomGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                stops: [0.0, 0.3],
                colors: [Colors.black87, Colors.transparent]),

            //sin codigo reutilizable
            /*
            const SizedBox.expand(
              child: DecoratedBox(
                  decoration: BoxDecoration(
                      //este es
                      gradient:
                          LinearGradient(begin: Alignment.topLeft, stops: [
                0.0,
                0.3
              ], colors: [
                Colors.black87,
                Colors.transparent,
              ]))),
            ),*/
          ],
        ),
      ),
    );
  }
}

class _MovieDetails extends StatelessWidget {
  final Movie movie;
  const _MovieDetails({required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyles = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start, //va a estar alineado al inicio
      children: [
        Padding(
            padding: const EdgeInsets.all(8),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // Imagen
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movie.posterPath,
                  width: size.width * 0.3,
                ),
              ),

              const SizedBox(width: 10),

              // Descripción
              SizedBox(
                width: (size.width - 40) * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(movie.title, style: textStyles.titleLarge),
                    Text(movie.overview),
                  ],
                ),
              )
            ])),

        // Generos de la película
        Padding(
          padding: const EdgeInsets.all(8),
          child: Wrap(
            children: [
              ...movie.genreIds.map((gender) => Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: Chip(
                      label: Text(gender),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ))
            ],
          ),
        ),

        //Mostrar actores ListView

        _ActorsByMovie(movieId: movie.id.toString()),
        const SizedBox(
          height: 50,
        )
      ],
    );
  }
}

class _ActorsByMovie extends ConsumerWidget {
  final String movieId;

  const _ActorsByMovie({required this.movieId});

  @override
  Widget build(BuildContext context, ref) {
    final actorsByMovie = ref.watch(actorsByMovieProvider);

    if (actorsByMovie[movieId] == null) {
      return const CircularProgressIndicator(strokeWidth: 2);
    }
    final actors = actorsByMovie[movieId]!;

    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: actors.length,
        itemBuilder: (context, index) {
          final actor = actors[index];

          return Container(
            padding: const EdgeInsets.all(8.0),
            width: 135,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Actor Photo
                FadeInRight(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      actor.profilePath,
                      height: 180,
                      width: 135,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // Nombre
                const SizedBox(
                  height: 5,
                ),

                Text(actor.name, maxLines: 2),
                Text(
                  actor.character ?? '',
                  maxLines: 2,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow
                          .ellipsis), //el TextOverflow.ellipsis, hace que si hay mcho texto aparescan puntitos seguidos
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CustomGradient extends StatelessWidget {
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final List<double> stops;
  final List<Color> colors;

  const _CustomGradient(
      {this.begin = Alignment.centerLeft,
      this.end = Alignment.centerRight,
      required this.stops,
      required this.colors});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: begin, end: end, stops: stops, colors: colors))),
    );
  }
}
