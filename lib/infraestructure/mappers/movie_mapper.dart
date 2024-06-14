//el objetivo de este mapper es leer diferentes modelos y crear la entidad o
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infraestructure/models/moviedb/movie_moviedb.dart';

import '../models/moviedb/movie_details.dart';

//para traer los datos de todas las peliculas
class MovieMapper {
  //vamos a crear un metodo que sirve para mapear los atributos de MovieMovieDB
  static Movie movieDBToEntity(MovieMovieDB moviedb) => Movie(
      adult: moviedb.adult,
      //aqui vamos a validar si es que el backdropPath es diferente de un string vacio, entonces
      //coloco la imagen que viede desde el api,
      //caso contrario voy a utilizar una imagen por defecto (en este caso busque una imagen cualquiera de internet)
      backdropPath: (moviedb.backdropPath != '') 
        ? 'https://image.tmdb.org/t/p/w500${ moviedb.backdropPath }'
        : 'https://sd.keepcalms.com/i-w600/keep-calm-poster-not-found.jpg',
      genreIds: moviedb.genreIds.map((e) => e.toString()).toList(),//con el map transformamos los enteros a string
      id: moviedb.id,
      originalLanguage: moviedb.originalLanguage,
      originalTitle: moviedb.originalTitle,
      overview: moviedb.overview,
      popularity: moviedb.popularity,
      //aqui vamos a validar si es que el posterPath es diferente de un string vacio, entonces
      //coloco la imagen que viede desde el api,
      //caso contrario voy a utilizar una imagen por defecto (en este caso busque una imagen cualquiera de internet)
      posterPath: (moviedb.posterPath != '')
        ? 'https://image.tmdb.org/t/p/w500${ moviedb.posterPath }'
        : 'no-poster',//si es que intento leer el caso cotrario de esta condicion va a saltar un error, por que eso no se va a oder mostrar en un widget, para eso en el data source se utiliza el where para evitar hacer validaciones en flutter
      releaseDate: moviedb.releaseDate,
      title: moviedb.title,
      video: moviedb.video,
      voteAverage: moviedb.voteAverage,
      voteCount: moviedb.voteCount
    );

    //Meodo para traer el detalle de una pelicula
     static Movie movieDetailsToEntity( MovieDetails moviedb ) => Movie(
      adult: moviedb.adult,
      backdropPath: (moviedb.backdropPath != '') 
        ? 'https://image.tmdb.org/t/p/w500${ moviedb.backdropPath }'
        : 'https://sd.keepcalms.com/i-w600/keep-calm-poster-not-found.jpg',
      genreIds: moviedb.genres.map((e) => e.name ).toList(),
      id: moviedb.id,
      originalLanguage: moviedb.originalLanguage,
      originalTitle: moviedb.originalTitle,
      overview: moviedb.overview,
      popularity: moviedb.popularity,
      posterPath: (moviedb.posterPath != '')
        ? 'https://image.tmdb.org/t/p/w500${ moviedb.posterPath }'
        : 'https://sd.keepcalms.com/i-w600/keep-calm-poster-not-found.jpg',
      releaseDate: moviedb.releaseDate,
      title: moviedb.title,
      video: moviedb.video,
      voteAverage: moviedb.voteAverage,
      voteCount: moviedb.voteCount
    );

}
