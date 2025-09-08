# Inventario Ruby on Rails

Este proyecto implementa un sistema de control de inventario utilizando Ruby on Rails 8 y PostgreSQL, con Hotwire para la interacción UI.

## Objetivo

Construir una aplicación web que permita gestionar artículos y personas en un sistema de inventario, incluyendo las transferencias de portadores.

## Reglas de Negocio

### Artículos
*   **Identificador único**
*   **Modelo**
*   **Marca**
*   **Fecha de ingreso**
*   Cada artículo tiene un **portador actual**, que es una persona.

### Personas
*   **Identificador único**
*   **Nombre**
*   **Apellido**
*   Cada persona puede portar cero o más artículos.

### Transferencias
*   Un artículo puede ser transferido de una persona a otra.
*   Se debe mantener un **historial de portadores por artículo**.
*   Se debe mantener un **historial de artículos portados por persona**.

## Funcionalidades Mínimas Implementadas

*   **Listar artículos:** Muestra todos los artículos con sus datos básicos.
*   **Detalle de artículo:**
    *   Datos básicos del artículo.
    *   Portador actual.
    *   Historial de portadores (transferencias).
*   **Listar personas:** Muestra todas las personas con sus datos básicos.
*   **Detalle de persona:**
    *   Datos básicos de la persona.
    *   Artículos que porta actualmente.
    *   Historial de artículos portados (transferencias).
*   **Agregar artículo:** Formulario para crear nuevos artículos.
*   **Agregar persona:** Formulario para crear nuevas personas.
*   **Registrar transferencia de artículo:** Formulario para transferir un artículo de una persona a otra, actualizando el portador del artículo y registrando la transferencia en el historial.
*   **Seeds obligatorias:** Se han cargado 3 personas, 5 artículos y 2 transferencias de ejemplo.

## Funcionalidades Opcionales (Pendientes)

*   ABM de marcas y modelos.
*   Filtros de artículos por marca, modelo y fecha de ingreso.
*   Exportar marcas, modelos, artículos, personas y transferencias a CSV.
*   Importar marcas, modelos, artículos, personas y transferencias desde CSV.
*   Login básico utilizando `rails generate authentication`.
*   API JSON para artículos (productos), personas y transferencias.
*   Pruebas automatizadas (RSpec o Minitest) mínimas.

## API

Para facilitar las pruebas de la API, se incluye una colección de Postman (`postman_collection.json`) en la raíz del proyecto. Puedes importarla en Postman para tener acceso a todos los endpoints de la API, incluyendo ejemplos de peticiones para `login`, `registro`, `articulos`, `personas` y `transferencias`.

## Diseño de la Solución

### Decisiones de Diseño
*   **Framework:** Ruby on Rails 8.
*   **Base de Datos:** PostgreSQL (utilizado en el entorno Docker).
*   **Capa de Interacción UI:** Hotwire (Turbo Frames y Stimulus) para una experiencia de usuario dinámica sin escribir JavaScript complejo. Esto se alinea con la filosofía de Rails de "HTML over the wire".

### Mockups UI/UX (Descripción Textual)

#### 1. Página Principal (Personas#index)
*   **Encabezado:** Enlaces de navegación a "Personas", "Artículos", "Transferencias".
*   **Sección "Personas":**
    *   Lista de personas, mostrando "Nombre" y "Apellido".
    *   Para cada persona:
        *   **Artículos Portados Actualmente:** Lista de artículos que la persona tiene asignados, con enlaces a los detalles del artículo.
        *   **Historial de Artículos Portados (Transferencias):** Lista de transferencias donde la persona fue portador anterior o nuevo portador, mostrando la fecha, el artículo y los portadores involucrados.
    *   Enlace para "Mostrar esta persona" (detalle).
    *   Enlace para "Editar esta persona".
    *   Botón para "Eliminar esta persona".

#### 2. Detalle de Artículo (Articulos#show)
*   **Encabezado:** Enlaces de navegación a "Personas", "Artículos", "Transferencias".
*   **Sección "Artículo":**
    *   Datos básicos: Marca, Modelo, Fecha de Ingreso.
    *   Portador Actual: Nombre del portador actual con enlace a su detalle.
*   **Sección "Historial de Portadores (Transferencias)":**
    *   Lista de transferencias relacionadas con este artículo, mostrando quién transfirió a quién y la fecha.
*   **Acciones:**
    *   Enlace para "Registrar Transferencia" (para este artículo).
    *   Enlace para "Editar este artículo".
    *   Enlace para "Volver a artículos".
    *   Botón para "Eliminar este artículo".

#### 3. Detalle de Persona (Personas#show)
*   **Encabezado:** Enlaces de navegación a "Personas", "Artículos", "Transferencias".
*   **Sección "Persona":**
    *   Datos básicos: Nombre, Apellido.
*   **Sección "Artículos que porta actualmente":**
    *   Lista de artículos que la persona tiene asignados, con enlaces a los detalles del artículo.
*   **Sección "Historial de Artículos Portados":**
    *   Lista de transferencias donde la persona fue portador anterior o nuevo portador, mostrando la fecha, el artículo y los portadores involucrados.
*   **Acciones:**
    *   Enlace para "Editar esta persona".
    *   Enlace para "Volver a personas".
    *   Botón para "Eliminar esta persona".

#### 4. Formulario de Nueva Transferencia (Transferencias#new)
*   **Encabezado:** Enlaces de navegación.
*   **Título:** "Nueva Transferencia".
*   **Formulario:**
    *   Campo de selección para "Artículo" (dropdown con marca y modelo).
    *   Campo de selección para "Nuevo Portador" (dropdown con nombre y apellido).
    *   Campo de fecha para "Fecha".
    *   Botón "Crear Transferencia".
*   **Acciones:**
    *   Enlace para "Volver al listado".

### Diagrama del Modelo de Datos (Entidades y Relaciones)

El modelo de datos se compone de tres entidades principales: `Persona`, `Articulo` y `Transferencia`.

*   **Persona:**
    *   `id` (PK)
    *   `nombre` (string)
    *   `apellido` (string)
    *   `created_at`, `updated_at` (timestamps)
    *   **Relaciones:**
        *   `has_many :articulos, foreign_key: :portador_id` (Una persona puede portar muchos artículos)
        *   `has_many :transferencias_como_portador_anterior, class_name: "Transferencia", foreign_key: "portador_anterior_id"` (Una persona puede haber sido portador anterior en muchas transferencias)
        *   `has_many :transferencias_como_nuevo_portador, class_name: "Transferencia", foreign_key: "nuevo_portador_id"` (Una persona puede haber sido nuevo portador en muchas transferencias)
        *   `todas_las_transferencias` (método para obtener todas las transferencias donde la persona está involucrada)

*   **Articulo:**
    *   `id` (PK)
    *   `marca` (string)
    *   `modelo` (string)
    *   `fecha_ingreso` (date)
    *   `portador_id` (FK a `personas.id`, representa el portador actual)
    *   `created_at`, `updated_at` (timestamps)
    *   **Relaciones:**
        *   `belongs_to :portador, class_name: "Persona"` (Un artículo pertenece a un portador actual)
        *   `has_many :transferencias, dependent: :destroy` (Un artículo puede tener muchas transferencias en su historial)

*   **Transferencia:**
    *   `id` (PK)
    *   `articulo_id` (FK a `articulos.id`)
    *   `portador_anterior_id` (FK a `personas.id`)
    *   `nuevo_portador_id` (FK a `personas.id`)
    *   `fecha` (date)
    *   `created_at`, `updated_at` (timestamps)
    *   **Relaciones:**
        *   `belongs_to :articulo` (Una transferencia pertenece a un artículo)
        *   `belongs_to :portador_anterior, class_name: "Persona"` (El portador anterior de la transferencia)
        *   `belongs_to :nuevo_portador, class_name: "Persona"` (El nuevo portador de la transferencia)

## Planificación del Proyecto

Aquí está la lista de tareas que se ha seguido y las pendientes:

- [x] Analizar los requisitos del ejercicio y crear una lista de tareas detallada.
- [x] Revisar la estructura del proyecto y los archivos existentes.
- [x] Identificar las funcionalidades mínimas y opcionales faltantes.
- [x] Implementar el modelo de datos y las relaciones.
- [x] Implementar las funcionalidades de Artículos (Listar, Detalle, Agregar).
- [x] Implementar las funcionalidades de Personas (Listar, Detalle, Agregar).
- [x] Implementar las funcionalidades de Transferencias (Registrar, Historial).
- [x] Cargar las seeds obligatorias (3 personas, 5 artículos, 2 transferencias).
- [ ] Implementar funcionalidades opcionales (ABM de marcas y modelos, filtros, exportar/importar CSV, login, API JSON).
- [x] Crear mockups UI/UX y diagrama del modelo de datos.
- [x] Actualizar el README con instrucciones, decisiones de diseño, mockups, modelo de datos y planificación.
- [x] Implementar pruebas automatizadas.
- [x] Verificar el cumplimiento de los criterios de evaluación.

## Instrucciones de Instalación y Ejecución

### Requisitos
*   Docker Desktop (para Windows/macOS) o Docker Engine (para Linux) instalado y en ejecución.
*   Git.

### Pasos para levantar el proyecto
1.  **Clonar el repositorio:**
    ```bash
    git clone https://github.com/juanpiRiv/RubyOnRailsChallenge-1-INVENTARIO.git
    cd my-app
    ```

2.  **Construir las imágenes de Docker:**
    ```bash
    docker-compose build
    ```

3.  **Iniciar los contenedores y la aplicación:**
    ```bash
    docker-compose up -d
    ```

4.  **Acceder al contenedor de Rails para preparar la base de datos:**
    ```bash
    docker-compose exec web bash
    ```
    Una vez dentro del contenedor, ejecuta los siguientes comandos para crear la base de datos, ejecutar las migraciones y cargar los datos de ejemplo:
    ```bash
    bundle install
    rails db:create
    rails db:migrate
    rails db:seed
    exit
    ```

5.  **Acceder a la aplicación web:**
    Abre tu navegador y navega a `http://localhost:3000`.

### Comandos Útiles
*   **Detener los contenedores:**
    ```bash
    docker-compose down
    ```
*   **Detener y eliminar contenedores y volúmenes (para un reinicio limpio):**
    ```bash
    docker-compose down -v
    ```
*   **Ver logs de los contenedores:**
    ```bash
    docker-compose logs -f
    ```
*   **Acceder a la consola de Rails dentro del contenedor:**
    ```bash
    docker-compose exec web rails console
    ```
*   **Ejecutar pruebas (dentro del contenedor):**
    ```bash
    rails test
    ```
*   **Resetear base de datos (dentro del contenedor):**
    ```bash
    rails db:drop db:create db:migrate db:seed
    ```

## Criterios de Evaluación (Auto-evaluación)

*   **Correctitud del modelo de datos y relaciones:** Implementado y verificado.
*   **Implementación clara y mantenible del código:** Se ha buscado mantener la claridad y seguir las convenciones de Rails.
*   **Calidad de la UI/UX (aunque sea simple, debe permitir ejecutar el flujo completo):** Las funcionalidades mínimas están operativas y permiten el flujo completo de gestión de personas, artículos y transferencias.
*   **Validaciones y manejo de errores:** Se utilizan las validaciones por defecto de Rails en los formularios. Se podría mejorar con validaciones personalizadas.
*   **Documentación (README y comentarios claros):** El README ha sido actualizado con la información solicitada.
*   **Funcionalidades opcionales (suman puntos pero no son obligatorias):** Pendientes de implementación.
*   **Pruebas unitarias y coverage:** Implementadas y pasando.
