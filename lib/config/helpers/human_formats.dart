import 'package:intl/intl.dart';


class HumanFormats {
  //creo el metodo como static para poder utilizarlo directamente y no tener que instanciarlo
  static String number( double number, [ int decimals = 0 ] ) {//recibo como parametro el numero que quiero que retorne, y el numero de decimales, es opcional, si no se envia nada su valor va a ser 0 por defecto

  //utilizamos el paquete
    return NumberFormat.compactCurrency(
      decimalDigits: decimals,
      symbol: '',
      locale: 'en'
    ).format(number);//es el numero que mando como referencia
  }
//metodo para formatear la fecha
  static String shortDate( DateTime date ) {    
    final format = DateFormat.yMMMEd('es');
    return format.format(date);
  }

}