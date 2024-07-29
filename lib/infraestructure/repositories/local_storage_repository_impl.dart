import 'package:cinemapedia/domain/datasources/local_storage_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/local_storage_repository.dart';
import 'package:flutter/material.dart';

//esta clase va a extender del LocalStorageRepository, que se ubica en cinemapedia/domain/repositories/local_storage_repository.dart'
//para solucionar el error luego de crear la lase nos ubicamos sobre IsarDatasource, tecleamos "ctrl + ."
// y seleccionamos create 3 missing override, en este caso son solo ttres por que estos son los
//metos creados en el datasource
class LocalStorageRepositoryImpl extends LocalStorageRepository {
  final LocalStorageDatasource
      datasource; //CON ESTE DATASOURCE YA UEDO TENER ACCESO A CUALQUIER DATASOURCE
  LocalStorageRepositoryImpl(this.datasource);

  @override
  Future<bool> isMovieFavorite(int movieId) {
    return datasource.isMovieFavorite(movieId);
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) {
    return datasource.loadMovies(limit: limit, offset: offset);
  }

  @override
  Future<void> toggleFavorite(Movie movie) {
    return datasource.toggleFavorite(movie);
  }
}
