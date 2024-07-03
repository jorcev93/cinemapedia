import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

//esta funcion es la que voy a utilizar para mandar a llamar las peliculas
typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

//para que no marque error, hay que sobreescribir los metodos que nos da error
//para ello me ubico sobre el nombre de la calse y tecleo "ctrl + .", para que se me sobre escriban los metodos
class SearchMovieDelegate extends SearchDelegate<Movie?> {
  final SearchMoviesCallback searchMovies;
  final List<Movie> initialMovies;
  //NOTA: SI SABEMOS QUE SOLO VA A ESCUCHAR UN WIDGET LO PONEMOS DEJAR ASI, PERO SI NO SABEMOS ES
  //RECOMENDABLE UTILIZAR EL .broadcast()
  // StreamController debounceMovies = StreamnController();//si se lo deja asi solo va a escuchar un listener, por eso no conviene
  StreamController<List<Movie>> debouncedMovies = StreamController
      .broadcast(); //asi se escucha una lista de listeners de varios lugares

  SearchMovieDelegate(
      {required this.searchMovies, required this.initialMovies});
  Timer? _debounceTimer; //esto me permite determinar un periodo de tiempo

  //metodo para cerrar los streams
  //lo voy a mandar a llamar cuando ya no vaya a utilizar el delegate
  //por eso lo voy a utilizar en el buildLeading
  void clearStreams() {
    debouncedMovies.close();
  }

  //Creamos un nuevo metodo para emitir el nuevo resultado de las peliculas
  void _onQuerChange(String query) {
    //print('Query string cambiando');
    if (_debounceTimer?.isActive ?? false)
      _debounceTimer!
          .cancel(); //si _debounceTimer esta activo va a ser false, pero si es activo lo voy a limpiar
    //aqui defino el timepo que voy a esperar antes de emitir otro valor, cada ves que la persona deja de escribir
    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      //esto lo pongo aqui y no al inicio, por que yo quiero conservar en pantalla los resultados hasta que la ersona deje de escribir
      //TODO buscar peliculas y emitir al stream
      if (query.isEmpty) {
        //aqui valido si esq el query esta vacio solo regurese una lista de peliculas vacias
        debouncedMovies.add([]);
        return;
      }
      //si ya tenemos un query qe no esta vacio entonces se hace lo siguiente
      final movies = await searchMovies(
          query); //con esto obtengo las peliculas utilizando el searchMovies
      debouncedMovies.add(movies); //aqui añado las peliculas
    });
    //print('Buscando peliculas');
  }

  //este override no es obligatorio,vsolo es para cambiar el texto "Search" por "Buscar película", en el cuadro de busqueda
  @override
  String get searchFieldLabel => 'Buscar película';

  //esto es para describir las opciones
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      //validamos si es que el cuadro de busqueda esta vacio o lleno
      //si esque esta vacio no va a aparecer el icono "X", para borrar lo que estabamos escribiendo
      //if (query.isEmpty) esta validacion la puedo ahcer directamente desde FadeIn con esta linea "animate: query.isEmpty"
      FadeIn(
        animate: query
            .isNotEmpty, //valido si esque el cuadro de busqueda esta vacio o no
        duration: const Duration(
            milliseconds:
                200), //determino el timpeo de espera para que aparezca el boton de borrar
        child: IconButton(
            //el query, es una palabra reservada del SearchDelegate
            //lo que estoy haciendo aqui es un icono con una "x", para borrar el texto que estoy escribiendo en el cuadro de busqueda
            onPressed: () => query = '',
            icon: const Icon(Icons.clear_rounded)),
      )
    ];
  }

  //esto seria para definir un icono como el que se tiene al inicio del search
  //en este caso es un icono con una flecha de regreso
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        //si esque no encontro lo que buscaba o si solo quiere regresar, regreso null
        onPressed: () {
          clearStreams();
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back_ios_new_rounded));
  }

  //esto es para los resultados que van a aparecer cuando la persona presione enter
  @override
  Widget buildResults(BuildContext context) {
    return const Text('buildResults');
  }

  //esto es para que los resultados aparezcan cuando la persona esta escribiendo
  @override
  Widget buildSuggestions(BuildContext context) {
    _onQuerChange(query);
    //aqui lo vamos a cambiar el FutureBuilder por un StreamBuilder
    return StreamBuilder(
        //future: searchMovies(query),//al ya no utilizar el future lo vamos a cambiar por un stream
        initialData: initialMovies,
        stream: debouncedMovies.stream,
        builder: (context, snapshot) {
          final movies = snapshot.data ?? [];
          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) => _MovieItem(
              movie: movies[index],
              onMovieSelected: (context, movie) {
                clearStreams();
                close(context, movie);
              },
            ),
            //se puede dejar asi
            /*
            itemBuilder: (context, index) {
              final movie = movies[index];

              return _MovieItem(movie: movie);
*/
            //con esto solo mostraba la lista
            /*return ListTile(
                title: Text(movie.title),
              );
            },*/
          );
        });
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;
  final Function
      onMovieSelected; //esta varieble me va a servir para saber que se va a recibir una funcion
  const _MovieItem({required this.movie, required this.onMovieSelected});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        onMovieSelected(context, movie);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            //imagen
            SizedBox(
              width: size.width * 0.20,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(movie.posterPath),
              ),
            ),

            const SizedBox(
              width: 10,
            ),

            //Description
            SizedBox(
              width: size.width * 0.70,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: textStyle.titleMedium,
                  ),
                  movie.overview.length > 100
                      ? Text('${movie.overview.substring(0, 100)}...')
                      : Text(movie.overview),
                  Row(
                    children: [
                      Icon(Icons.star_half_rounded,
                          color: Colors.yellow.shade800),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        HumanFormats.number(movie.voteAverage, 1),
                        style: textStyle.bodyMedium!
                            .copyWith(color: Colors.yellow.shade900),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
