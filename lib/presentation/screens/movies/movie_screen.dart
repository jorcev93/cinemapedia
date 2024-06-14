//Esta pantalla va a ser para presentar los datos de una sola pelicula

//el StatefulWidget, me sirve para saber cuando cargo o estoy cargando entre otras cosas, utilizando el inisState
import 'package:flutter/material.dart';

class MovieScreen extends StatefulWidget {
  static const name = 'mvie-screen';
  final String movieId;
  const MovieScreen({super.key, required this.movieId});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  
  //me sirve para manejar un cache local, para efienizar y no estar haceindo una nueva peticion si esq ya la hicimos anterormente
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('MovieID: ${widget.movieId}'),
    ));
  }
}
