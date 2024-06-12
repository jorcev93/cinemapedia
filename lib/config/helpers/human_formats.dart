import 'package:intl/intl.dart';


class HumanFormats {
  //creo el metodo como static para poder utilizarlo directamente y no tener que instanciarlo
  static String number( double number ) {//recibo como parametro el numero que quiero que retorne

  //utilizamos el paquete
    final formattedNumber = NumberFormat.compactCurrency(
      decimalDigits: 0,
      symbol: '',
      locale: 'en'
    ).format(number);//es el numero que mando como referencia

    return formattedNumber;
  }

}