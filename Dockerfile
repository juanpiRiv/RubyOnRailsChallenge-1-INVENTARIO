FROM ruby:3.2.3

# Instalar dependencias del sistema
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client yarn build-essential

# Crear carpeta de la app
WORKDIR /usr/src/app

# Copiar Gemfile y Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Instalar gems
RUN bundle install

# Copiar el resto del proyecto
COPY . .

# Comando por defecto
CMD ["rails", "server", "-b", "0.0.0.0"]
