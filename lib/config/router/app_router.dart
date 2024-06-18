//voy a utilizar gorouter y para ello hay que instalarlo
//para instalarlo utilizo pubspec y tecleo el comando go_router
import 'package:go_router/go_router.dart';
import '../../presentation/screens/screens.dart';
//aqui va la configuracion de rutas
final appRouter = GoRouter(
    initialLocation: '/', //
    routes: [
      GoRoute(
          path: '/',
          name: HomeScreen.name,
          builder: (context, state) => const HomeScreen(),
          //qui van a ir las rutas hijas
          routes: [
            GoRoute(
              //como es una ruta hija, ya no va el primer "/", pasaria de esto "'/movie/:id'" a esto "'movie/:id'"
                path:'movie/:id', //aqui estoy diciendo que va a recibir un id, y este siempre va aser un strig
                name: MovieScreen.name,
                builder: (context, state) {
                  //esta variable es para obtener el parametro del id que viene en el path
                  final movieId = state.pathParameters['id'] ?? 'no-id';
                  return MovieScreen(movieId: movieId);
                })
          ]),

      //si lo dejo aqui en el momento que se recarga la pagina, se va a perder
      //el boton de regreso, para ello es mejor ubicarlo dentro de la ruta de  "HomeScreen"
      //para que sea una ruta hija de HomeScreen
      /*GoRoute(
          path:
              '/movie/:id', //aqui estoy diciendo que va a recibir un id, y este siempre va aser un strig
          name: MovieScreen.name,
          builder: (context, state) {
            //esta variable es para obtener el parametro del id que viene en el path
            final movieId = state.pathParameters['id'] ?? 'no-id';
            return MovieScreen(movieId: movieId);
          })*/
    ]);
