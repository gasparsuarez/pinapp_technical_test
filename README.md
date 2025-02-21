## Prueba técnica PinApp

## Descripción

-  En este proyecto se hace una integración nativa de IOS con Swift a través de [PlatformChannels], donde realizamos dos operaciones HTTP. En uno obtenemos un listado de Posts y en el otro obtenemos sus respectivos Comentarios, luego se realiza la lógica correspondiente con Flutter y Dart para mostrarle la respuesta final al usuario.

-  Se utiliza una estructura de carpetas siguiendo los conceptos de Clean Architecture, donde definimos las siguientes capas:
    * [Data]: Punto de acceso para los datos de apis o servicios para ser gestionados por nuestros repositorios y modelos.
    * [Domain]: Es el centro, donde definimos nuestras entidades y reglas de negocio.
    * [Presentation]: La capa mas externa de nuestra aplicación, donde tenemos lógica para la interacción con el usuario, acá manejamos los gestores de estados, componentes, etc.

- Para la configuración y navegación entre pantallas utilizo `GoRouter` por su flexibilidad y organización de rutas.

- Utilizo `Get_It` para registrar y manejar las dependencias, que luego seran inyectadas en repositorios, datasources y blocs. De esta manera, no tenemos que generar múltiples instancias y dependencias ocultas en las diferentes capas.

- Como gestor de estados utilicé `flutter_bloc`, por preferencia y por su fácil implementación, separando la logica negocio de la lógica de UI.

- También utilizo la clase `Either` para manejar dos tipos de respuesta cuando se llama a un método HTTP. En este caso manejo la clase `Left` que contiene el error y la clase `Right` que contiene la respuesta esperada o satisfactoria. Luego podemos utilizar programación funcional para obtener sus respectivos valores de cada clase.

## Instalación

1. Abrir terminal.
2. Ingresar ``flutter pub get`` para instalar dependencias.
3. Ingresar ``flutter run`` para ejecutar el proyecto.

## Librerías 

- Gestor de estado: `Flutter_bloc / Cubits`
- Navegación: `Go_Router`
- Inyección de dependencias: `Get_It`

