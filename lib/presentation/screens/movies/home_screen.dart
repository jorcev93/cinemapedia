import 'package:flutter/material.dart';
import '../../views/views.dart';
import '../../widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  static const name = 'home-screen'; //nombre de la ruta que va autilizar go_router para esta pantalla
  final int pageIndex;
  const HomeScreen({super.key, required this.pageIndex});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

//* Este Mixin es necesario para mantener el estado en el PageView
class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin {
  
  //DE LA LINEA 18 A LA 34 SE UTILIZA SE AGREGARON POR QUE SE UTILIZA MIXIN PARA MANTENER EL ESTADO DE LA PAGINA
  late PageController pageController;//controlador de la pagina

  //inicializamos el controlador de la pagina
  @override
  void initState() {
    super.initState();
    pageController = PageController(
      keepPage: true
    );
  }

  //liberamos el controlador de la pagina
  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  final viewRoutes = const <Widget>[
    HomeView(),
    PopularView(),//<---- Popular view
    FavoritesView(),
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);//esto es necesario para mantener el estado de la pagina
    //si el controlador de la pagina tiene clientes, entonces animamos a la pagina que se le indique
    if ( pageController.hasClients ) {  
        pageController.animateToPage(//animamos a la pagina que se le indique
        widget.pageIndex, //pagina a la que se va a animar
        curve: Curves.easeInOut, //curva de animacion
        duration: const Duration( milliseconds: 250),
      );
    }
    /* sin utilizar el mixin
    return  Scaffold(
      // al utilizar las variables de entorno, el scaffold no puede ser constante por que va a cambiar en ejecucion
      //el IndexedStack sirve para preservar el estado en el tiempo
      body: IndexedStack(
        index: widget.pageIndex,
        children: viewRoutes,
      ),
      bottomNavigationBar:
          CustomBottomNavigation(currentIndex:widget.pageIndex), //mandamos a llamar el menu de navegacion que se muestra en la parte inferior
      /*esto era una prueba, para ver como utilizar las variables de entornno
      body: Center(
        //child: Text(dotenv.env['THE_MOVIEDB_KEY']??'No hay api key'),//asi seria si no utilizo una clase a parte
        child: Text(Environment.theMovieDbKey),//aqui utilio una clase a parte para tener acceso a todas las variables de entorno ms facilmente
      ),*/
    );
    */

  //UTILIZANDO EL MIXIN
    return Scaffold(
      body: PageView(
        //* Esto evitará que rebote 
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        // index: pageIndex,
        children: viewRoutes,
      ),
      bottomNavigationBar: CustomBottomNavigation( 
        currentIndex: widget.pageIndex,
      ),
    );
  }
  
  @override
  bool get wantKeepAlive => true;
  }
  
