class MovieMovieDB {
    MovieMovieDB({
        required this.adult,
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
        required this.voteCount,
    });

    final bool adult;
    final String backdropPath;
    final List<int> genreIds;
    final int id;
    final String originalLanguage;
    final String originalTitle;
    final String overview;
    final double popularity;
    final String posterPath;
    final DateTime? releaseDate;//aqui estableco que el releaseDate, puede ser nulo
    final String title;
    final bool video;
    final double voteAverage;
    final int voteCount;

    factory MovieMovieDB.fromJson(Map<String, dynamic> json) => MovieMovieDB(
        adult: json["adult"] ?? false,
        backdropPath: json["backdrop_path"] ?? '',
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        overview: json["overview"] ?? '',
        popularity: json["popularity"]?.toDouble(),
        posterPath: json["poster_path"] ?? '',//si es que no hay posterPath, entonces va a ser un string vacio
        //aqui voy a validar para que no me de error cuando no tenga la fecha
        //aqui valido que hacer si es que es nulo
        releaseDate:json["release_date"] !=null && json["release_date"].toString().isNotEmpty//si json["release_date"] es diferente de null y no esta vacio
        ? DateTime.parse(json["release_date"]) //regresa la fecha
        :null,//caso contrario regresa null
        title: json["title"],
        video: json["video"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
    );

    Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "id": id,
        "original_language": originalLanguage,
        "original_title": originalTitle,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        //como modiicamos en e  MovieMovieDB.fromJson
        //aqui tambien debemos modificar
        "release_date": (releaseDate != null)  // si el releaseDate es diferente de null
        //como ya esty haciendo la evaluacion de que si es null, entonces al cambiar esto "releaseDate", por esto "releaseDate!", ya estoy diciendo que siempre va a tener un valor
        ? "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}"//entoces regreso la releaseDate
        :null,//caso contrario voy a regresar null
        "title": title,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
    };
}