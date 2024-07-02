//este appbar lo voy a colocar en esta carpeta share por que ees algo gueneral n o es propio de una pantalla

import 'package:cinemapedia/presentation/delegate/search_movie_delegate.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors =
        Theme.of(context).colorScheme; //esto es para definir el color del tema
    final titleStyle = Theme.of(context)
        .textTheme
        .titleMedium; //este define el estilo de titulo del (cinepedia)
    return SafeArea(
        //este SafeArea sirve para no ocupar el espacio del notch
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          children: [
            Icon(Icons.movie_outlined,
                color: colors.primary), //es el icono del appbar
            const SizedBox(width: 5), //espacio entre icono y el Text del appbar
            Text(
              'Cinepedia',
              style: titleStyle,
            ),
            const Spacer(), //este espacer hace que el icono de busqueda se separe del texto "cinepedia" y se ubique al final

            //boton de busqueda
            IconButton(
                onPressed: () {
                  final movieRepository =ref.read(movieRepositoryProvider);
                  //aqui ytiizamos una funcion propia de flutter para las busquedas
                  showSearch(
                    context: context, 
                    //el delegate es el que se va a encargar de realizar la busqueda
                    delegate: SearchMovieDelegate(
                      searchMovies: movieRepository.searchMovies
                    )
                    );
                },
                icon: const Icon(Icons.search))
          ],
        ),
      ),
    ));
  }
}
