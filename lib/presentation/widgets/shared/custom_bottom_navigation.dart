//este es el menu de navegacion que se mueestra en la parte inferior de la pantalla

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigation extends StatelessWidget {
  final int currentIndex;
  const CustomBottomNavigation({super.key, required this.currentIndex});


  //metodo para saber el indice del tab al cual quiero navegar
  void onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/home/0');
        break;
      case 1:
        context.go('/home/1');
        break;
      case 2:
        context.go('/home/2');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return BottomNavigationBar(
      currentIndex: currentIndex,//aqui definimos el indice del tab que se muestra
      onTap: (value) => onItemTapped(context, value), //aqui definimos el metodo que se ejecuta al hacer click en un tab
      elevation: 0, //aqui definimos el menu de navegacion
      selectedItemColor: colors.primary,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_max), label: 'Inicio'),
        BottomNavigationBarItem(
            icon: Icon(Icons.label_outline), label: 'Populares'),
        BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline), label: 'Favoritos'),
      ],
    );
  }
}
