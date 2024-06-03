//NOTA LAS IMPORTACIONES AQUI SI IMMPORTAN
//PRIMERO VAN LAS IMPORTACIONES PROPIAS DE DART

//LUEGO IMPORTACIONES PROPIAS DE MATERIAL 
import 'package:flutter/material.dart';
//LUEGO PAQUETES DE TERCEROS
//POR ULTIMO NUESTRAS DEPENDENCIAS
import 'package:cinemapedia/config/router/app_router.dart';
import 'package:cinemapedia/config/theme/app_theme.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp.router(//despues del "MaterialAPP", se agrega ".router", para poder utilizar go_router
      routerConfig: appRouter,//referencio a la calse donde tengo las rutas de las pantallas
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),//llamamos al theme que creamos
      
    );
  }
}
