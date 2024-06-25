//en este archivo voy a crear la instancia del MovieReppositoryImpl

//este va a ser un provider que no va a ser modificado luego de se creacion
//puede ser un provider de solo lectura, para ello voy a instalar "flutter_riverpod"
//cuando digo que nunca va a cambiar, me refiero a que la data no se va a modificar
/* explicacion de la variable  movieRepositoryProvider*/
//movieRepository: es el nombre del repositorio que estoy proveyendo
//Provaider: Es proveedor de informacion
import 'package:cinemapedia/infraestructure/datasources/actor_moviedb_datasource.dart';
import 'package:cinemapedia/infraestructure/repositories/actor_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//este provider es inmutable, su objetivo es proveer a todos los provider de adentro la informacion necesaria
// para puedan consultar la informacion de MovieRepositoryImpl
final actorsRepositoryProvider = Provider((ref) {
  return ActorRepositoryImpl(ActorMovieDbDatasource());
});//esto es el provaider encargado de proveer este repositorio
