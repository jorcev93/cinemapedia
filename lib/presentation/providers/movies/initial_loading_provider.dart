//este provider es de solo lectura
//este provider va a servor para determinar si presentar el full_screen_loader
//o el "CustomScrollView", que se encuentra en el home_screen
import 'movies_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final initialLoadingProvider = Provider<bool>((ref) {
  final step1 = ref.watch(nowPlayingMoviesProvider).isEmpty; //este va a ser el listado de peliculas
  final step2 = ref.watch(popularMoviesProvider).isEmpty;
  final step3 = ref.watch(upcomingMoviesProvider).isEmpty;
  final step4 = ref.watch(topRatedMoviesProvider).isEmpty;
  if (step1 || step2 || step4 || step3 || step4) return true;//
  return false; //terminamos de cargar
});
