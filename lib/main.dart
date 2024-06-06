//NOTA LAS IMPORTACIONES AQUI SI IMMPORTAN
//PRIMERO VAN LAS IMPORTACIONES PROPIAS DE DART

//LUEGO IMPORTACIONES PROPIAS DE MATERIAL
import 'package:flutter/material.dart';
//LUEGO PAQUETES DE TERCEROS
/*luego de instalar y convigurar el paquete para utilizar las variables de entorno, lo importamos*/
import 'package:flutter_dotenv/flutter_dotenv.dart';
//POR ULTIMO NUESTRAS DEPENDENCIAS
import 'package:cinemapedia/config/router/app_router.dart';
import 'package:cinemapedia/config/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//para poder utilizar las variables de entorno debemos modificar el main
//antes estaba asi void main(){}
//debemos dejarla de esta forma
/*
Future<void> main() async {
  runApp(const MainApp());
  await dotenv.load(fileName: '.env');
}
 */
Future<void> main() async {
  await dotenv.load(
      fileName:
          '.env'); //inicializamos el paquete para que lea el archivo .env, y se pueda utilizar de forma global
  //una vez instalado riverpod debemos hacer lo siguiente
  runApp(const ProviderScope(child: MainApp()));//el providerScope, es el que va a contener la referencia a todos los providers de riverpod
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      //despues del "MaterialAPP", se agrega ".router", para poder utilizar go_router
      routerConfig:
          appRouter, //referencio a la calse donde tengo las rutas de las pantallas
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(), //llamamos al theme que creamos
    );
  }
}
