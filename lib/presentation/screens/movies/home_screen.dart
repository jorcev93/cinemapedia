/*NOTA IMPORTANTE */
//aL MOMENTO DE HACER LOS TABS, COMO YA TENEMOS EL HOMEVIEW, CORTAMOS EL
//CODIGO Y LO PEGAMOS EN EL ARCHIVO home_view.dar ubicado en la carpeta "views/home_views"

import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen'; //nombre de la ruta que va autilizar go_router para esta pantalla
  final Widget childView;//este childView vamos a tener que recibirlo si lo queremos utilizar
  const HomeScreen({super.key, required this.childView});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // al utilizar las variables de entorno, el scaffold no puede ser constante por que va a cambiar en ejecucion
      body: childView,
      bottomNavigationBar: const CustomBottomNavigation(), //mandamos a llamar el menu de navegacion que se muestra en la parte inferior
      /*esto era una prueba, para ver como utilizar las variables de entornno
      body: Center(
        //child: Text(dotenv.env['THE_MOVIEDB_KEY']??'No hay api key'),//asi seria si no utilizo una clase a parte
        child: Text(Environment.theMovieDbKey),//aqui utilio una clase a parte para tener acceso a todas las variables de entorno ms facilmente
      ),*/
    );
  }
}
