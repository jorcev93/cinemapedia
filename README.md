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
Para cambiar el nombre de la aplicación
......
dart run change_app_package_name:main com.new.package.name

donde: 
new.package -> ppodriamos poner el nombre de nuestro sitio web, o cualquier nombre
name        -> seria el nombre de la aplicación y debe ser unico

entonces: 
com.new.package.name, vendria a ser el identificdor de nuestra app

Modificaion al comando para ejecuar en la terminal:
dart run change_app_package_name:main com.jorcev.cinemapedia

Nota:
Despues de cambiar el nombre de la app podemos eliminar el paquete si se desea 


......