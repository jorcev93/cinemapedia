
//usualmente el nombre de este archivo es el mismo nombre de la entidad(ubicada en la carpeta entities) que usamos en la app
//el objetivo del mapper es tener la conversion de como luce un objeto a nuestro tipo de objeto perzonalizado que usamos en nuestra app
import 'package:cinemapedia/domain/entities/actor.dart';

import '../models/moviedb/credits_response.dart';

class ActorMapper {
  static Actor castToEntity( Cast cast ) =>
      Actor(
        id: cast.id, 
        name: cast.name, 
        profilePath: cast.profilePath != null
        ? 'https://image.tmdb.org/t/p/w500${ cast.profilePath }'
        : 'https://st3.depositphotos.com/4111759/13425/v/600/depositphotos_134255710-stock-illustration-avatar-vector-male-profile-gray.jpg', 
        character: cast.character,
      );
}