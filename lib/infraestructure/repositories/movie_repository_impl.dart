//esta implementacion va a llamar el datasource y del datasource va a llamar esos metodos
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/entities/video.dart';
import 'package:cinemapedia/domain/repositories/movie_repository.dart';

//utilizamos "ctrl + .", para crear el override faltante
class MovieRepositoryImpl extends MoviesRepository {
  final MoviesDatasource
      datasource; //mandamos a llamar la clase padre, es decir la clase que va a implementar

  MovieRepositoryImpl(this.datasource);

  //aqui vamos a mandar a llamar el datasource, para que llame este getNowPlaying
  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return datasource.getNowPlaying(
        page:
            page); //retornamos el datasource y recibimos como parametro el page
  }

  //aqui vamos a mandar a llamar el datasource, para que llame este getupComing
  @override
  Future<List<Movie>> getUpcoming({int page = 1}) {
    return datasource.getUpcoming(page: page);
  }

  //aqui vamos a mandar a llamar el datasource, para que llame este getPopular
  @override
  Future<List<Movie>> getPopular({int page = 1}) {
    return datasource.getPopular(page: page);
  }

  //aqui vamos a mandar a llamar el datasource, para que llame este getTopRate
  @override
  Future<List<Movie>> getTopRated({int page = 1}) {
    return datasource.getTopRated(page: page);
  }

  @override
  Future<Movie> getMovieById(String id) {
    return datasource.getMovieById(id);
  }

  @override
  Future<List<Movie>> searchMovies(String query) {
    return datasource.searchMovies(query);
  }

  @override
  Future<List<Movie>> getSimilarMovies(int movieId) {
     return datasource.getSimilarMovies(movieId);
  }

  @override
  Future<List<Video>> getYoutubeVideosById(int movieId) {
     return datasource.getYoutubeVideosById(movieId);
  }
}
