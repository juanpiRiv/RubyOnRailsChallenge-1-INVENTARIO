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

## Documentación del Flujo para Crear Modelos Persona, Articulo y Transferencia en Rails con PostgreSQL dentro de Docker

Este documento describe el flujo completo para crear los modelos Persona, Articulo y Transferencia en una aplicación Rails que utiliza PostgreSQL como base de datos y se ejecuta dentro de un contenedor Docker.

### 1. Entrar al Contenedor Docker

Primero, necesitas acceder al contenedor donde corre la aplicación Rails. Ejecuta el siguiente comando en tu terminal:

```bash
docker exec -it my-app-web-run-1cdff3a2be1b bash
```

Esto abrirá un shell dentro del contenedor `my-app-web`, donde Rails y las gemas están instaladas.

### 2. Instalar un Editor de Texto (Opcional)

Si el contenedor no tiene un editor de texto, puedes instalar uno. Por ejemplo, para instalar `nano`:

```bash
apt update
apt install nano -y
```

Ahora puedes editar cualquier archivo con:

```bash
nano ruta/al/archivo.rb
```

### 3. Crear el Modelo y Migración Persona

Para crear el modelo `Persona` y su migración correspondiente, utiliza el siguiente comando:

```bash
rails g model Persona nombre:string apellido:string
```

Esto generará los siguientes archivos:

- `db/migrate/20250904215857_create_personas.rb` (La fecha puede variar)
- `app/models/persona.rb`
- Archivos de prueba en `test/`

Luego, migra la base de datos para crear la tabla `personas`:

```bash
rails db:migrate
```

Resultado: La tabla `personas` se creará correctamente en la base de datos PostgreSQL.

### 4. Crear el Modelo y Migración Articulo

Para crear el modelo `Articulo` y su migración, utiliza el siguiente comando:

```bash
rails g model Articulo marca:string modelo:string fecha_ingreso:date portador:references
```

Edita la migración generada (`db/migrate/xxxxxxxxxxxxxx_create_articulos.rb`) para apuntar correctamente a la tabla `personas` usando la clave foránea:

```ruby
class CreateArticulos < ActiveRecord::Migration[8.0]
  def change
    create_table :articulos do |t|
      t.string :marca
      t.string :modelo
      t.date :fecha_ingreso
      t.references :portador, foreign_key: { to_table: :personas }

      t.timestamps
    end
  end
end
```

Define las asociaciones en los modelos:

```ruby
# app/models/articulo.rb
class Articulo < ApplicationRecord
  belongs_to :portador, class_name: "Persona"
end

# app/models/persona.rb
class Persona < ApplicationRecord
  has_many :articulos, foreign_key: :portador_id
end
```

Luego, migra la base de datos:

```bash
rails db:migrate
```

### 5. Crear el Modelo y Migración Transferencia

Para crear el modelo `Transferencia` y su migración, utiliza el siguiente comando:

```bash
rails g model Transferencia articulo:references persona:references fecha:date
```

Migra la base de datos:

```bash
rails db:migrate
```

Resultado: La tabla `transferencia` se creará correctamente con referencias a `articulos` y `personas`.

### 6. Resultado Final

Todas las migraciones se ejecutarán correctamente.

#### Tablas en PostgreSQL:

| Tabla         | Columnas principales                                  |
|---------------|-------------------------------------------------------|
| personas      | id, nombre, apellido, created_at, updated_at          |
| articulos     | id, marca, modelo, fecha_ingreso, portador_id, timestamps |
| transferencia | id, articulo_id, persona_id, fecha, timestamps        |

#### Relaciones Definidas en los Modelos:

- `Persona` `has_many :articulos`
- `Articulo` `belongs_to :portador` (`Persona`)
- `Transferencia` `belongs_to :articulo`
- `Transferencia` `belongs_to :persona`

## Modelos y Migraciones Completos

A continuación, se muestra una versión lista para copiar/pegar de todos los modelos y migraciones completos, con las asociaciones ya corregidas y sin errores, lista para usar en tu proyecto.

### app/models/persona.rb

```ruby
class Persona < ApplicationRecord
  has_many :articulos, foreign_key: :portador_id
end
```

### app/models/articulo.rb

```ruby
class Articulo < ApplicationRecord
  belongs_to :portador, class_name: "Persona"
end
```

### app/models/transferencium.rb

```ruby
class Transferencium < ApplicationRecord
  belongs_to :articulo
  belongs_to :persona
end
```

### db/migrate/20250904215857_create_personas.rb

```ruby
class CreatePersonas < ActiveRecord::Migration[8.0]
  def change
    create_table :personas do |t|
      t.string :nombre
      t.string :apellido

      t.timestamps
    end
  end
end
```

### db/migrate/20250904220034_create_articulos.rb

```ruby
class CreateArticulos < ActiveRecord::Migration[8.0]
  def change
    create_table :articulos do |t|
      t.string :marca
      t.string :modelo
      t.date :fecha_ingreso
      t.references :portador, foreign_key: { to_table: :personas }

      t.timestamps
    end
  end
end
```

### db/migrate/20250904220218_create_transferencia.rb

```ruby
class CreateTransferencia < ActiveRecord::Migration[8.0]
  def change
    create_table :transferencia do |t|
      t.references :articulo, null: false, foreign_key: true
      t.references :persona, null: false, foreign_key: true
      t.date :fecha

      t.timestamps
    end
  end
end

## 🔧 Comandos y Tips Útiles

### Rails

*   Levantar servidor Rails:

    ```bash
    rails s
    ```

*   Crear un modelo con migración:

    ```bash
    rails g model NombreModelo atributo1:tipo atributo2:tipo
    ```

*   Ejecutar migraciones:

    ```bash
    rails db:migrate
    ```

*   Revertir la última migración:

    ```bash
    rails db:rollback
    ```

*   Resetear base de datos:

    ```bash
    rails db:drop db:create db:migrate
    ```

*   Abrir consola Rails:

    ```bash
    rails console
    ```

*   Abrir consola de base de datos:

    ```bash
    rails dbconsole
    ```

### Docker

*   Construir imágenes y levantar contenedores:

    ```bash
    docker-compose up --build -d
    ```

*   Ver logs de contenedores:

    ```bash
    docker-compose logs -f
    ```

*   Acceder al contenedor de Rails:

    ```bash
    docker exec -it my-app-web-1 bash
    ```

*   Detener y eliminar contenedores:

    ```bash
    docker-compose down
    ```

*   Reconstruir contenedores después de cambios en Dockerfile:

    ```bash
    docker-compose build
    docker-compose up -d
    ```

### PostgreSQL dentro de Docker

*   Acceder a PostgreSQL desde el contenedor:

    ```bash
    docker exec -it my-app-db-1 psql -U postgres
    ```

*   Ver todas las bases de datos:

    ```sql
    \l
    ```

*   Cambiar de base de datos:

    ```sql
    \c nombre_base
    ```

*   Ver tablas:

    ```sql
    \dt
    ```

*   Ver estructura de una tabla:

    ```sql
    \d nombre_tabla
    ```

*   Ejecutar consultas SQL:

    ```sql
    SELECT * FROM nombre_tabla;
    ```

### Tips

*   Siempre ejecutar migraciones dentro del contenedor si estás usando Docker.
*   Para borrar todo y reconstruir el entorno:

    ```bash
    docker-compose down -v
    docker-compose up --build -d
    ```

*   Mantén un volumen montado para que los cambios en Rails se reflejen en tu máquina host.
*   Usa `rails db:seed` para poblar datos iniciales si lo configuraste.
