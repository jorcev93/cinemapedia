//en este archivo vamos a colocar las variabes de entorno pero
//estaticas para que no sea necesario instanciarlas a la hora de usarlas
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String theMovieDbKey = dotenv.env['THE_MOVIEDB_KEY'] ?? 'no hay api key';
}
