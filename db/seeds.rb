# Limpiar datos existentes
puts "Limpiando la base de datos..."
Transferencia.destroy_all
Articulo.destroy_all
Persona.destroy_all

# Crear Personas
puts "Creando personas..."
persona1 = Persona.create!(nombre: "Juan", apellido: "Pérez")
persona2 = Persona.create!(nombre: "Maria", apellido: "García")
persona3 = Persona.create!(nombre: "Carlos", apellido: "Rodriguez")
puts "#{Persona.count} personas creadas."

# Crear Artículos
puts "Creando artículos..."
articulo1 = Articulo.create!(marca: "Dell", modelo: "Laptop XPS 15", fecha_ingreso: Date.today - 30.days, portador: persona1)
articulo2 = Articulo.create!(marca: "Apple", modelo: "Monitor Studio Display", fecha_ingreso: Date.today - 20.days, portador: persona1)
articulo3 = Articulo.create!(marca: "Logitech", modelo: "Teclado MX Keys", fecha_ingreso: Date.today - 15.days, portador: persona2)
articulo4 = Articulo.create!(marca: "Samsung", modelo: "SSD 1TB", fecha_ingreso: Date.today - 10.days, portador: persona3)
articulo5 = Articulo.create!(marca: "Sony", modelo: "Auriculares WH-1000XM4", fecha_ingreso: Date.today - 5.days, portador: persona3)
puts "#{Articulo.count} artículos creados."

# Crear Transferencias
puts "Creando transferencias..."
# Transferencia 1: articulo1 de persona1 a persona2
Transferencia.create!(articulo: articulo1, portador_anterior: persona1, nuevo_portador: persona2, fecha: Date.today - 10.days)
articulo1.update!(portador: persona2)

# Transferencia 2: articulo2 de persona1 a persona3
Transferencia.create!(articulo: articulo2, portador_anterior: persona1, nuevo_portador: persona3, fecha: Date.today - 5.days)
articulo2.update!(portador: persona3)
puts "#{Transferencia.count} transferencias creadas."

# Crear Usuario Administrador
puts "Creando usuario administrador..."
admin_user = User.find_or_initialize_by(email_address: "admin@example.com")
if admin_user.new_record?
  admin_user.password = "password"
  admin_user.password_confirmation = "password"
  admin_user.save!
elsif admin_user.authentication_token.blank?
  admin_user.generate_authentication_token
  admin_user.save!
end
puts "Usuario administrador creado/encontrado: #{admin_user.email_address}"
puts "Token de autenticación para admin@example.com: #{admin_user.authentication_token}"

puts "¡Seed completado!"
