import 'package:flutter/material.dart';
import '../../views/views.dart';
import '../../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen'; //nombre de la ruta que va autilizar go_router para esta pantalla
  final int pageIndex;
  const HomeScreen({super.key, required this.pageIndex});

  final viewRoutes = const <Widget>[
    HomeView(),
    SizedBox(),//<---- categorias view
    FavoritesView(),
  ];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      // al utilizar las variables de entorno, el scaffold no puede ser constante por que va a cambiar en ejecucion
      //el IndexedStack sirve para preservar el estado en el tiempo
      body: IndexedStack(
        index: pageIndex,
        children: viewRoutes,
      ),
      bottomNavigationBar:
          CustomBottomNavigation(currentIndex:pageIndex), //mandamos a llamar el menu de navegacion que se muestra en la parte inferior
      /*esto era una prueba, para ver como utilizar las variables de entornno
      body: Center(
        //child: Text(dotenv.env['THE_MOVIEDB_KEY']??'No hay api key'),//asi seria si no utilizo una clase a parte
        child: Text(Environment.theMovieDbKey),//aqui utilio una clase a parte para tener acceso a todas las variables de entorno ms facilmente
      ),*/
    );
  }
}
