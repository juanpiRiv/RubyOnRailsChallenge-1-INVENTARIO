# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end



puts "Seeding datos iniciales..."

# Personas
juan = Persona.create!(nombre: "Juan", apellido: "Pérez")
maria = Persona.create!(nombre: "María", apellido: "Gómez")

# Artículos
notebook = Articulo.create!(marca: "Dell", modelo: "Inspiron 15", fecha_ingreso: Date.today - 10, portador: juan)
celular  = Articulo.create!(marca: "Samsung", modelo: "Galaxy S22", fecha_ingreso: Date.today - 5, portador: maria)

# Transferencias
Transferencia.create!(articulo: notebook, persona: maria, fecha: Date.today - 3)
Transferencia.create!(articulo: celular, persona: juan, fecha: Date.today - 1)

puts "Seeds cargados correctamente."