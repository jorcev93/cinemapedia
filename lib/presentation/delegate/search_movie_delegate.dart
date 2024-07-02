import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

//esta funcion es la que voy a utilizar para mandar a llamar las peliculas
typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

//para que no marque error, hay que sobreescribir los metodos que nos da error
//para ello me ubico sobre el nombre de la calse y tecleo "ctrl + .", para que se me sobre escriban los metodos
class SearchMovieDelegate extends SearchDelegate<Movie?> {
  final SearchMoviesCallback searchMovies;

  SearchMovieDelegate({required this.searchMovies});

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
        onPressed: () => close(context, null),
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
    return FutureBuilder(
        future: searchMovies(query),
        builder: (context, snapshot) {
          final movies = snapshot.data ?? [];
          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return ListTile(
                title: Text(movie.title),
              );
            },
          );
        });
  }
}
