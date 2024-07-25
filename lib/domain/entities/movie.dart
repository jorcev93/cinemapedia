//NOTA AUNA VEZ INSTALADO Isar, Modificamos esta entidad y las que necesitemos
import 'package:isar/isar.dart';

//cuando se agrega este part no importa si da error, por que es un archivo que se va a crear automaticamente
//cuando abramos la terminal y ejecutemos el comando  "flutter pub run build_runner build"
part 'movie.g.dart';

@collection //agregamos este collection una vez que instalamos isar
class Movie {
  Id? isarId; //lo hago opcional para que isar autoincremente automaticamente
  final bool adult;
  final String backdropPath;
  final List<String> genreIds;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final DateTime releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  Movie(
      {required this.adult,
      required this.backdropPath,
      required this.genreIds,
      required this.id,
      required this.originalLanguage,
      required this.originalTitle,
      required this.overview,
      required this.popularity,
      required this.posterPath,
      required this.releaseDate,
      required this.title,
      required this.video,
      required this.voteAverage,
      required this.voteCount});
}
