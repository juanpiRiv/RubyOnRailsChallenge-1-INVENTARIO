require "test_helper"

class PersonaTest < ActiveSupport::TestCase
  setup do
    @persona_one = personas(:one)
    @persona_two = personas(:two)
    @articulo_one = articulos(:one)
    @articulo_two = articulos(:two)
    @articulo_three = articulos(:three)
  end

  test "should be valid" do
    persona = Persona.new(nombre: "Nuevo", apellido: "Usuario")
    assert persona.valid?
  end

  test "should require nombre" do
    persona = Persona.new(apellido: "Usuario")
    assert_not persona.valid?
    assert_includes persona.errors[:nombre], "can't be blank"
  end

  test "should require apellido" do
    persona = Persona.new(nombre: "Nuevo")
    assert_not persona.valid?
    assert_includes persona.errors[:apellido], "can't be blank"
  end

  test "should have associated articulos" do
    assert_equal 2, @persona_one.articulos.count
    assert_includes @persona_one.articulos, @articulo_one
    assert_includes @persona_one.articulos, @articulo_two
  end

  test "should have associated transferencias as portador_anterior" do
    # persona_one es portador_anterior en 2 fixtures. Si creamos una más, serán 3.
    assert_difference('@persona_one.transferencias_como_portador_anterior.count', 1) do
      Transferencia.create!(articulo: @articulo_three, portador_anterior: @persona_one, nuevo_portador: @persona_two, fecha: Date.today)
    end
    assert_equal 3, @persona_one.transferencias_como_portador_anterior.count
  end

  test "should have associated transferencias as nuevo_portador" do
    # persona_one no es nuevo_portador en los fixtures. Si creamos una, será 1.
    assert_difference('@persona_one.transferencias_como_nuevo_portador.count', 1) do
      Transferencia.create!(articulo: @articulo_three, portador_anterior: @persona_two, nuevo_portador: @persona_one, fecha: Date.today)
    end
    assert_equal 1, @persona_one.transferencias_como_nuevo_portador.count
  end

  test "todas_las_transferencias should return all associated transfers" do
    # persona_one es portador_anterior en 2 fixtures.
    # persona_one no es nuevo_portador en los fixtures.
    # Total inicial para persona_one: 2
    # persona_two es nuevo_portador en 2 fixtures.
    # persona_two es portador_anterior en 0 fixtures.
    # Total inicial para persona_two: 2

    # Crear una transferencia donde persona_one es portador_anterior
    Transferencia.create!(articulo: @articulo_three, portador_anterior: @persona_one, nuevo_portador: @persona_two, fecha: Date.today - 1.day)
    # Crear una transferencia donde persona_one es nuevo_portador
    Transferencia.create!(articulo: @articulo_three, portador_anterior: @persona_two, nuevo_portador: @persona_one, fecha: Date.today)
    
    # Ahora persona_one tiene 3 como portador_anterior y 1 como nuevo_portador = 4
    assert_equal 4, @persona_one.todas_las_transferencias.count
    # Ahora persona_two tiene 1 como portador_anterior y 3 como nuevo_portador = 4
    assert_equal 4, @persona_two.todas_las_transferencias.count
  end
end
