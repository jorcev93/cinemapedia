# cinemapedia
# Dev
1. Copiar el .env.template y renomdrarlo a .env
2. cambiar las variables de entorno (THE_MOVIEDB_KEY)
3. Cambios en la entidad, hay que ejecutar el comando 
......
flutter pub run build_runner build
......
A new Flutter project.

# Para producción
PARA CAMBIAR EL NOMBRE DE LA APP
......
Utilizo el paquete:
change_app_package_name

Lo instalo como paquete de desarrollo, por que no es necesario para correr la app

Ejecuto en el terminal el comando: 
dart run change_app_package_name:main com.new.package.name

donde: 
new.package -> ppodriamos poner el nombre de nuestro sitio web, o cualquier nombre
name        -> seria el nombre de la aplicación y debe ser unico

entonces: 
com.new.package.name, vendria a ser el identificdor de nuestra app

Modificaion al comando para ejecuar en la terminal:
dart run change_app_package_name:main com.jorcev.infocine

Nota:
Despues de cambiar el nombre de la app podemos eliminar el paquete si se desea 
......

PARA CAMBIAR EL ICONO DE LA APP
......
Utilizo el paquete:
flutter_launcher_icons

Lo instalo como paquete de desarrollo, por que no es necesario para correr la app

En el pubspec.yaml agrego:

flutter_launcher_icons:
  android: "launcher_icon"
  ios: true
  image_path: "assets/icon/icon.png"
  min_sdk_android: 21 # android min sdk min:16, default 21

Creo el directorio: 
    assets/icon/

Copio en el directorio el icono que voy a utilizar

Ejecuto el comando en la terminal:
dart run flutter_launcher_icons

......

PARA CAMBIAR EL SPLASH SCREEN
......
Se instala el paquete:
  flutter_native_splash

En el yaml se agrega la configuracion:
  flutter_native_splash:
  color: "#252829"
  image: "assets/icon/app-icon-2.png"
  android: true
  ios: true

Se ejecuta el comando:
  flutter pub run flutter_native_splash:create
......

ANDROID AAB
......
Se ejecuta el comando:
  flutter build appbundle
......