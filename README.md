# Rick and Morty App

## Descripción
Aplicación móvil que consume la API de Rick and Morty para mostrar información detallada sobre los personajes de la serie. El proyecto ha sido diseñado siguiendo los principios de **Clean Architecture** 

## API Reference
El proyecto utiliza la [Rick and Morty API](https://rickandmortyapi.com/) como fuente de datos.

### Base URL
`https://rickandmortyapi.com/api/`

### Endpoints utilizados
- **GET** `/character`: Obtiene la lista paginada de todos los personajes.
  - **Parámetros de consulta**:
    - `page`: Número de la página a consultar.
    - `name`: Filtro por nombre del personaje.

## Estructura del Proyecto

```
lib/
 ├── main.dart                          # Punto de entrada de la aplicación
 ├── core/                              # Componentes compartidos y configuraciones
 │    ├── constants/                    # Constantes globales 
 │    ├── error/                        # Manejo de excepciones y fallos
 │    ├── network/                      # Configuración de red (Dio/Retrofit)
 │    ├── providers/                    # Proveedores globales
 │    └── utils/                        # Utilidades y funciones de ayuda
 └── features/                          # Organización basada en características (Feature-first)
      └── character/                    # Módulo de personajes de Rick and Morty
           ├── data/                    # Capa de Datos
           │    ├── datasource/         # Fuentes de datos (remotas)
           │    ├── mapper/             # Conversión entre Modelos y Entidades
           │    ├── model/              # Modelos de datos (DTOs)
           │    ├── providers/          # Proveedores de la capa de datos
           │    └── repository/         # Implementación de los repositorios
           ├── domain/                  # Capa de Dominio (Reglas de Negocio)
           │    ├── entities/           # Entidades de negocio puras
           │    ├── providers/          # Proveedores de Riverpod para el dominio
           │    ├── repositories/       # Interfaces de los repositorios
           │    └── usecases/           # Lógica de negocio específica (Casos de uso)
           └── presentation/            # Capa de Presentación (UI)
                ├── providers/          # Controladores de estado (Notifiers)
                ├── character_detail/   # Pantalla y widgets de detalle
                └── character_list/     # Pantalla y widgets de lista principal
```

## Dependencias Principales

| Librería | Versión | Propósito |
| :--- | :--- | :--- |
| **flutter_riverpod** | ^3.3.2 | Gestión de estado reactiva y segura. |
| **riverpod_annotation** | ^4.0.3 | Simplifica la creación de proveedores mediante generación de código. |
| **freezed_annotation** | ^3.1.0 | Generación de modelos inmutables y uniones (unions). |
| **dio** | ^5.9.2 | Cliente HTTP potente para realizar peticiones de forma eficiente. |
| **retrofit** | ^4.9.2 | Generador de cliente REST para Dio, facilitando el consumo de APIs. |
| **equatable** | ^2.0.8 | Facilita la comparación de objetos en Dart sin necesidad de sobrescribir operadores manualmente. |

## Guía de Desarrollo

Para agregar una nueva funcionalidad, sigue estos pasos:

1. **Dominio**:
    * Crea la **Entidad** en `domain/entities`.
    * Define la interfaz del **Repositorio** en `domain/repositories`.
    * Implementa los **Casos de Uso** en `domain/usecases`.
2. **Datos**:
    * Crea el **Modelo** de datos en `data/model` (DTOs).
    * Implementa el **Mapper** en `data/mapper` para transformar entre Modelo y Entidad.
    * Implementa la fuente de datos en `data/datasource`.
    * Implementa el **Repositorio** definido en el dominio en `data/repository`.
3. **Presentación**:
    * Crea el **Provider** en `presentation/providers` para manejar el estado de la UI.
    * Diseña la pantalla y widgets en su carpeta correspondiente dentro de `presentation/`.
4. **Generación de Código**:
    * Ejecuta: `flutter pub run build_runner build --delete-conflicting-outputs`

## Cómo ejecutar el proyecto

1. **Prerrequisitos**: Instalación del [SDK de Flutter](https://docs.flutter.dev/get-started/install).
2. **Clonar el repositorio**:
   ```bash
   git clone https://github.com/eduardc23/rick_and_morty_app.git
   cd rick_and_morty_app
   ```
3. **Instalar dependencias**: `flutter pub get`
4. **Generar código**: `flutter pub run build_runner build --delete-conflicting-outputs`
5. **Ejecutar**: `flutter run`

## Licencia y Autor

- **Autor**: [Eduard](https://github.com/eduardc23)
- **Licencia**: Este proyecto está bajo la Licencia MIT.
