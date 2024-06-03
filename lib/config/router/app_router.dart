//voy a utilizar gorouter y para ello hay que instalarlo
//para instalarlo utilizo pubspec y tecleo el comando go_router

import 'package:cinemapedia/presentation/screens/movies/home_screen.dart';
import 'package:go_router/go_router.dart';

//aqui va la configuracion de rutas
final appRouter = GoRouter(
  initialLocation: '/',//
  routes: [
    GoRoute(path: '/',
    name: HomeScreen.name,
    builder: (context,state)=>const HomeScreen())
]);
