# Limpiar datos existentes
puts "Limpiando la base de datos..."
Transferencia.destroy_all
Articulo.destroy_all
Persona.destroy_all

# Crear Personas
puts "Creando personas..."
persona1 = Persona.create!(nombre: "Juan", apellido: "Pérez")
persona2 = Persona.create!(nombre: "Maria", apellido: "García")
puts "#{Persona.count} personas creadas."

# Crear Artículos
puts "Creando artículos..."
articulo1 = Articulo.create!(marca: "Dell", modelo: "Laptop XPS 15", fecha_ingreso: Date.today - 30.days, portador: persona1)
articulo2 = Articulo.create!(marca: "Apple", modelo: "Monitor Studio Display", fecha_ingreso: Date.today - 20.days, portador: persona1)
articulo3 = Articulo.create!(marca: "Logitech", modelo: "Teclado MX Keys", fecha_ingreso: Date.today - 15.days, portador: persona2)
puts "#{Articulo.count} artículos creados."

# Crear Transferencias
puts "Creando transferencias..."
Transferencia.create!(articulo: articulo1, persona: persona1, fecha: Date.today - 10.days)
Transferencia.create!(articulo: articulo2, persona: persona2, fecha: Date.today - 5.days)
Transferencia.create!(articulo: articulo1, persona: persona2, fecha: Date.today) # Reasignación
puts "#{Transferencia.count} transferencias creadas."

puts "¡Seed completado!"
