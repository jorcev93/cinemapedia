//NOTA: PARA ESTE "slideshow" UTILIZAMOS UN PAQUETE DE TERCEROS, PARA ELLO
//PRIMERO HAY QUE INSTALARLO
//EL PAQUETE SE LLAMA: card_swiper
//NOTA2: PARA LAS ANIMACIONES DE LA IMAGEN UTILIZAMOS FadeIn
//DEL PAQUETE QUE SE LLAMA: animate_do
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import '../../../domain/entities/movie.dart';
import 'package:go_router/go_router.dart';


class MoviesSlideshow extends StatelessWidget {
  final List<Movie>
      movies; //variable para almacenar la lista de movies, la importamos de la entidad movies
  const MoviesSlideshow(
      {super.key,
      required this.movies //este es un parametro nombrado por que siempre requerimos peliculas
      });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return SizedBox(
      height: 210, //altura
      width: double.infinity, //ancho
      child: Swiper(
        //lo iimportamos del paquete que intalamos
        viewportFraction:
            0.8, //con esto podemos ver una parte del video anterior y posterior
        scale: 0.9,
        autoplay: true, //esto es para que se este moviendo automaticamente
        //paginacion personalizada
        pagination:SwiperPagination(
          margin: const EdgeInsets.only(top:0),//con esto separo un poco los puntos de la imagen, y al establecerla en cero hago que baje todo lo que pueda
          //el DotSwiperPaginationBuilder, es builder preconfigurado
          builder: DotSwiperPaginationBuilder(
            //no pide un buil context, pero si como quiero que se vea
            activeColor: colors.primary,//este es el color primario
            color: colors.secondary//este es el color secundario
          )
        ),
        itemCount: movies.length,
        itemBuilder: (context, index) => _Slide(
            movie: movies[
                index]), //se utiliza la funcion flecha, por que el metodo retorna directamente, la forma qe esta comentada debajo tambien es valida
        /*En esta forma de funcion */
        /*itemBuilder: (context, index) {
          //final movie = movies[index];//no es necesario, mas facil pasarlo directamente  
          return _Slide(movie: movie)//sin pasarlo directamente
          return _Slide(movie: movies[index]);//pasandolo directamente
        },*/
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie; //variable que recibe una movie
  const _Slide(
      {required this.movie}); //no hace falta el "super.key" por que es privado, asi que lo elimino

  @override
  Widget build(BuildContext context) {
    //declaramos como variable, por que va a tener varias propiedades
    final decoration = BoxDecoration(
        borderRadius:
            BorderRadius.circular(20), //el radio va a ser circular de 20px
        boxShadow: const [
          BoxShadow(
            color: Colors.black45, //color de fondo
            blurRadius: 10, //este es el espacio de la sombra
            offset: Offset(0, 10), //son las coordenadas "x" e "y", de la sombra
          )
        ]);


    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: DecoratedBox(
        decoration: decoration,
        child: ClipRRect(
            //este ClipRRect, permite poder borde redondeado al widget
            borderRadius: BorderRadius.circular(20),
            child: GestureDetector(
            onTap: () => context.push('/home/0/movie/${ movie.id }'),
            child: FadeInImage(
              fit: BoxFit.cover,
              placeholder: const AssetImage('assets/loaders/bottle-loader.gif'),
              image: NetworkImage(movie.backdropPath),
            ),
            
            /*
            child: Image.network(
              movie.backdropPath,
              fit: BoxFit.cover,
              //el loadingBuilder es para saber si la imagen se construyo o no
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress != null) {
                  return const DecoratedBox(
                      decoration: BoxDecoration(color: Colors.black12));
                }
                //para utilizar FadeIn, debemos isntalar el paquete "animate_do"
                return FadeIn(child: child);//este chil basicamente es lo que ya construimos, sea con la imagen o no 
              },
            )*/
            ),
      ),
    ));
  }
}
