//este es el menu de navegacion que se mueestra en la parte inferior de la pantalla

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({super.key});


  //Metodo para que al momento de dar clic en el tap se quede seleccionado el tap
  //basicamente este me va a servir para saber el indice seleccionado del tap
  int getCurrentIndex(BuildContext context){
    final String location=GoRouterState.of(context).matchedLocation;
    switch (location){
      case '/':
      return 0;
      case '/categories':
      return 1;
      case '/favorites':
      return 2;
      default:
      return 0;
    }
  }



  //metodo para saber el indice del tab al cual quiero navegar
  void onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/');
        break;
       case 1:
        context.go('/');
        break;
       case 2:
        context.go('/favorites');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0, //aqui definimos el menu de navegacion
      currentIndex: getCurrentIndex(context),//defino el indice selecionado del tap
      //este onTap es para saber en el indice que estamos y a cual queremos navegar
      onTap: (value) => onItemTapped(context, value),//obtenemos el indice del tap
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_max), label: 'Inicio'),
        BottomNavigationBarItem(
            icon: Icon(Icons.label_outline), label: 'Categorias'),
        BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline), label: 'Favoritos'),
      ],
    );
  }
}
