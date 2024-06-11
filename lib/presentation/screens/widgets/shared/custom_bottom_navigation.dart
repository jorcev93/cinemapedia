//este es el menu de navegacion que se mueestra en la parte inferior de la pantalla

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({super.key});
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(//aqui definimos el menu de navegacion
      items: [
       BottomNavigationBarItem(icon: Icon(Icons.home_max), label: 'Inicio'),
       BottomNavigationBarItem(icon: Icon(Icons.label_outline), label: 'Categorias'),
       BottomNavigationBarItem(icon: Icon(Icons.favorite_outline), label: 'Favoritos'),
      ],
    );
  }
}