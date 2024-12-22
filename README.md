# PillBox

## Descripción
PillBox es una aplicación móvil desarrollada en Swift que permite al usuario tener el control de su tratamiento al alcance de su bolsillo. La gestión de diferentes perfiles de usuario y sus correspondientes medicamentos quedan almacenados en la memoria local del dispositivo usando Realm como motor de base de datos orientada a objetos; además, estos medicamentos podrán ser configurados según el intervalo entre tomas, la duración del tratamiento y la posibilidad de activar notificaciones móviles para mejorar la adherencia a éste.

## Funcionalidades
La aplicación desarrollada tiene como objetivo almacenar y manejar la lista de fármacos, así como sus tomas, de todos los miembros en una unidad familiar o red personal concreta, por ello cuenta con las siguientes funciones:
- **Punto de acceso**: Pantalla inicial que dará acceso a la aplicación al pulsar un botón de la misma.
- **Gestión de usuarios**: Se mostrarán todos los perfiles de usuarios almacenados; esta pantalla incluirá un botón para añadir nuevos usuarios y las celdas serán deslizables para eliminar los usuarios cuando se deslice a la izquierda.
- **Gestión de medicamentos**: Lista de medicamentos asociada a cada usuario, también incluirá la posibilidad de añadir nuevos fármacos a la lista mediante el botón de añadir y sus celdas seguirán la misma dinámica que los usuarios para ser eliminadas.
- **Configuración**: Para cada uno de los medicamentos añadidos o modificados.
- **Notificaciones**: Dentro de cada configuración del fármaco se puede activar la posibilidad de enviar notificaciones para recordar las tomas de dicho medicamento durante el periodo de tiempo indicado en la misma.

## Contribuciones
Las contribuciones son bienvenidas. Por favor, sigue los siguientes pasos:

Realiza un fork del repositorio.
Crea una nueva rama (git checkout -b feature/nueva-funcionalidad).
Realiza tus cambios y realiza commits (git commit -m 'Añadir nueva funcionalidad').
Envía tus cambios a tu repositorio fork (git push origin feature/nueva-funcionalidad).
Abre un Pull Request en GitHub.
