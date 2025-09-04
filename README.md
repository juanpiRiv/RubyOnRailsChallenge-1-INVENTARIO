# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## Instrucciones para levantar el servidor paso a paso

1.  Asegúrate de tener Docker instalado en tu máquina. Puedes encontrar las instrucciones de instalación en [docs.docker.com/get-docker](https://docs.docker.com/get-docker).

2.  Crea una carpeta para la nueva aplicación Rails:

    ```bash
    mkdir my-app
    cd my-app
    ```

    Si estás usando Windows, es posible que tengas que usar comandos diferentes para lograr el mismo resultado.

3.  Crea los archivos Docker.

    Crea un archivo llamado `Dockerfile-dev` con la siguiente configuración mínima para crear una imagen que soporte Ruby:

    ```dockerfile
    FROM ruby:3.2.3

    WORKDIR /usr/src/app
    ```

    Antes de construir la nueva imagen de Docker, crea un archivo llamado `docker-compose.yml` con el siguiente contenido:

    ```yaml
    services:
      web:
        build:
          context: ./
          dockerfile: Dockerfile-dev
        ports:
          - "3000:3000"
        volumes:
          - .:/usr/src/app
        command: rails s -b 0.0.0.0
    ```

    Este archivo configura un contenedor llamado `web` que expone el puerto 3000 (el puerto utilizado por Rails) y configura un volumen que monta la ruta actual de la máquina host a la carpeta `/usr/src/app` en el contenedor.

    El volumen es esencial para que cuando generemos la aplicación Rails en el contenedor, los archivos de plantilla persistan en el sistema de archivos del host.

4.  Genera una aplicación Rails.

    Ahora podemos acceder al terminal del contenedor mientras exponemos los puertos de servicio para que podamos acceder a la aplicación Rails más adelante a través de `localhost:3000`:

    ```bash
    docker-compose run --service-ports web bash
    ```

    Una vez dentro del contenedor, podemos instalar Rails y generar una nueva aplicación:

    ```bash
    gem install rails
    rails new . --name=my-app
    ```

    Después de ejecutar estos comandos, deberías ver todos los archivos generados por Rails en la carpeta del proyecto.

5.  Construye la imagen de Docker.

    ```bash
    docker-compose build
    ```

6.  Inicia la aplicación.

    ```bash
    docker-compose up
    ```

    Si todo va bien, deberías poder acceder a `localhost:3000` y ver la página de inicio predeterminada de tu nueva aplicación Rails.

## Usando PowerShell

Si estás usando PowerShell en Windows, puedes seguir estos pasos para ejecutar el proyecto:

1.  Asegúrate de tener Docker Desktop instalado y en ejecución.

## Volver a correr el proyecto

Si necesitas volver a correr el proyecto, sigue estos pasos:

1.  Abre PowerShell y navega hasta la carpeta del proyecto: `cd my-app`
2.  Ejecuta los comandos de Docker Compose:
    ```powershell
    docker-compose build
    docker-compose up
    ```
    Esto construirá la imagen de Docker e iniciará la aplicación.

Ahora deberías poder acceder a la aplicación en `localhost:3000`.

## Volver a correr el proyecto

Si necesitas volver a correr el proyecto, sigue estos pasos:

1.  Abre PowerShell y navega hasta la carpeta del proyecto: `cd my-app`
2.  Ejecuta los comandos de Docker Compose:
    ```powershell
    docker-compose build
    docker-compose up
    ```
    Esto construirá la imagen de Docker e iniciará la aplicación.

Ahora deberías poder acceder a la aplicación en `localhost:3000`.

2.  Abre PowerShell y navega hasta la carpeta del proyecto:

    ```powershell
    cd my-app
    ```

3.  Ejecuta los comandos de Docker Compose:

    ```powershell
    docker-compose build
    docker-compose up
    ```

    Esto construirá la imagen de Docker e iniciará la aplicación.

Ahora deberías poder acceder a la aplicación en `localhost:3000`.
