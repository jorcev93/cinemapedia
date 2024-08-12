
// cuando se utiliza el Provider.dispose, quiere decir que suando no se tuiliza ese vuelve al estado inicial
//cuando se utiliza Provider.falimy la diferencia esq que permite recibir un argumento
import 'package:cinemapedia/infraestructure/datasources/isar_datasource.dart';
import 'package:cinemapedia/infraestructure/repositories/local_storage_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localStorageRepositoryProvider = Provider((ref) {
  return LocalStorageRepositoryImpl(IsarDatasource());
});
