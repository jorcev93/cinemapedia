import 'package:intl/intl.dart';


class HumanFormats {
  //creo el metodo como static para poder utilizarlo directamente y no tener que instanciarlo
  static String number( double number,[int decimals=0] ) {//recibo como parametro el numero que quiero que retorne, y el numero de decimales, es opcional, si no se envia nada su valor va a ser 0 por defecto

  //utilizamos el paquete
    final formattedNumber = NumberFormat.compactCurrency(
      decimalDigits: 0,
      symbol: '',
      locale: 'en'
    ).format(number);//es el numero que mando como referencia

    return formattedNumber;
  }

}