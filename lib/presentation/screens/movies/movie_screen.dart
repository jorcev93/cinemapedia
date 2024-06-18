//NOTA: EL SCOPE, ES TODA LA CLASE DE ESTADO

//NOTA: COMO ESTAMOS UTILIZANDO EL ConsumerState el ref PODEMOS UTILIZARLO DIRECTAMENTE EN EL initState
//POR EL CONTRARIO SI LO ESTUVIÉRAMOS UTILIZANDO EN EL StatefulWidget, LO UTILIZRIOAMOS EN EL build

//NOTA: SE UTILIZA ref.read, cuando estamos en metodos que no se pueden redibujar,
// por ejemplo en callback, ontap, onpress, en el init...

//Esta pantalla va a ser para presentar los datos de una sola pelicula

//el StatefulWidget, me sirve para saber cuando cargo o estoy cargando entre otras cosas, utilizando el inisState
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/presentation/providers/movies/movie_info_provider.dart';

import '../../../domain/entities/movie.dart';

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
        physics: const ClampingScrollPhysics(),//esto es para quitar el efecto rebote que sabe tener en ios
        slivers: [
          _CustomSliverAppBar(movie: movie),
        ],
      ),
    );
  }
}

class _CustomSliverAppBar extends StatelessWidget {
  final Movie movie;
  const _CustomSliverAppBar({required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; //con esto se el tamaño del dipositivo
    //aqui vamos a empezar a construir un appbar perzonalizado
    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7, //aqui estoy diciendo que va a tomar el 70% de la pantalla
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        title: Text(
          movie.title,
          style: const TextStyle(fontSize: 20),
          textAlign: TextAlign.start,
        ),
        //el stack me permite colocar widgets unos sobre ottros
        background: Stack(
          children: [
            SizedBox.expand(//el expanded es para que tome todo el espacio posible del padre
              child: Image.network(movie.posterPath, fit: BoxFit.cover,),
            )
          ],
        ),
      ),
    );
  }
}

