//aqui tambien utilizamos el paquete intl, que sirve para que los nueros sean mas faciles de leer,
//para utilizarlo de forma mas sefura en lugar de utilizar el paquete directamente se crea
//un archivo en la siguiente ruta "config/helpers/human_formats.dart"

//NOTA HAY AVRIOS LUGARES DE DONDE PODRIAMOS TOMAR LA NAVEGACION PARA A IR A VER
//LAS CARACTERISTICAS DE CADA PELICULA, PERO AHORA VAMOS A IMPLEMENTARLA EN EL METODO
//DONDE SE MUESTRA LA IMAGEN, QUE SERIA EN "_Slide"
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/helpers/human_formats.dart';
import '../../../../domain/entities/movie.dart';

//para pode utilizar el listener tengo que cabiar el StatelessWidget a un StatefulWidget
class MovieHorizontalListview extends StatefulWidget {
  final List<Movie> movies; //lista de peliculas
  final String? title; //para el nombre de la peli
  final String? subtitle; //subtitulo de la peli
  final VoidCallback? loadNextPage;
  const MovieHorizontalListview(
      {super.key,
      required this.movies,
      this.title,
      this.subtitle,
      this.loadNextPage});

  @override
  State<MovieHorizontalListview> createState() =>
      _MovieHorizontalListviewState();
}

class _MovieHorizontalListviewState extends State<MovieHorizontalListview> {
  final scrollController = ScrollController();
  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (widget.loadNextPage == null)return; //si el loadNextPage es igual a null no se hace nada

      if ((scrollController.position.pixels + 200) >=
          scrollController.position.maxScrollExtent) {
        widget.loadNextPage!();
      }
    });
  }

  //cada que se crea un listener, inmediatamente se debe crear un dispose
  //esto se utiliza para destruir los widgets creados en el initstate
  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [
          if (widget.title != null || widget.subtitle != null)
            _Title(title: widget.title, subTitle: widget.subtitle),
          Expanded(
              child: ListView.builder(
            controller: scrollController,
            itemCount:
                widget.movies.length, //este es el numero de peliculas que tengo
            scrollDirection: Axis
                .horizontal, //es la horientacion en la que quiero que funcione mi escroll
            physics:
                const BouncingScrollPhysics(), //esto es para que todos tenga una apariencia igual
            itemBuilder: (context, index) {
              //este FadeInRight, es un metodo del paquete animate_do, es para la animacion del movie_Horizontal_listview
              return FadeInRight(child: _Slide(movie: widget.movies[index]));
            },
          ))
        ],
      ),
    );
  }
}

//este es la configuracion del widget del titulo
class _Title extends StatelessWidget {
  final String? title;
  final String? subTitle;

  const _Title({this.title, this.subTitle});

  @override
  Widget build(BuildContext context) {
    final titleStyle =
        Theme.of(context).textTheme.titleLarge; //este es el estylo del titulo

    return Container(
      padding: const EdgeInsets.only(
          top:
              10), //este pading es para que no se quede tan pegado al widget que esta arriba de el
      margin: const EdgeInsets.symmetric(
          horizontal:
              10), //este margen ayuda a que no el widget no nos quede pegado en los bordes
      child: Row(
        children: [
          if (title != null) Text(title!, style: titleStyle),
          const Spacer(), //este espacer separa el titulo y el subtitle y ubica al subtitle al otro extremo
          if (subTitle != null)
            FilledButton.tonal(
                //l damos un stilo de boton al subtitulo
                style: const ButtonStyle(visualDensity: VisualDensity.compact),
                onPressed: () {},
                child: Text(subTitle!))
        ],
      ),
    );
  }
}

//este es el slide que muestra las peliculas se ubica debajo de las titulo
class _Slide extends StatelessWidget {
  final Movie movie;

  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme; //estilo del texto

    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal:
              8), //separacion entre cada inamgen que se muestra de las peliculas
      child: Column(
        crossAxisAlignment: CrossAxisAlignment
            .start, //esto ahce que todos los hijos quden alineados al inicio
        children: [
          //* Imagen
          SizedBox(
            width: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                width: 150,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                          child: CircularProgressIndicator(strokeWidth: 2)),
                    );
                  }
                  return GestureDetector(
                    //se utiliza push por que quiero que se pueda regresar a la pantalla anterior
                    onTap: () => context.push('/movie/${movie.id}'), 
                    //este FadeIn, es un metodo del paquete animate_do, es para la animacion para que las imagenes tengan la misma altura
                    child: FadeIn(child: child),
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 5),

          //* Title
          SizedBox(
            width: 150,
            child: Text(
              movie.title,
              maxLines: 2,
              style: textStyles.titleSmall,
            ),
          ),

          //* Rating
          SizedBox(
            width: 150,
            child: Row(
              children: [
                Icon(Icons.star_half_outlined, color: Colors.yellow.shade800),
                const SizedBox(width: 3),
                Text('${movie.voteAverage}',
                    style: textStyles.bodyMedium
                        ?.copyWith(color: Colors.yellow.shade800)),
                const Spacer(),
                Text(HumanFormats.number(movie.popularity),
                    style: textStyles.bodySmall),
              ],
            ),
          )
        ],
      ),
    );
  }
}
