require "test_helper"

class ArticuloTest < ActiveSupport::TestCase
  setup do
    @persona = personas(:one) # Asume que tienes un fixture llamado 'one' en personas.yml
    @articulo = articulos(:one) # Asume que tienes un fixture llamado 'one' en articulos.yml
  end

  test "should be valid" do
    articulo = Articulo.new(marca: "TestMarca", modelo: "TestModelo", fecha_ingreso: Date.today, portador: @persona)
    assert articulo.valid?
  end

  test "should require marca" do
    articulo = Articulo.new(modelo: "TestModelo", fecha_ingreso: Date.today, portador: @persona)
    assert_not articulo.valid?
    assert_includes articulo.errors[:marca], "can't be blank"
  end

  test "should require modelo" do
    articulo = Articulo.new(marca: "TestMarca", fecha_ingreso: Date.today, portador: @persona)
    assert_not articulo.valid?
    assert_includes articulo.errors[:modelo], "can't be blank"
  end

  test "should require fecha_ingreso" do
    articulo = Articulo.new(marca: "TestMarca", modelo: "TestModelo", portador: @persona)
    assert_not articulo.valid?
    assert_includes articulo.errors[:fecha_ingreso], "can't be blank"
  end

  test "should require portador" do
    articulo = Articulo.new(marca: "TestMarca", modelo: "TestModelo", fecha_ingreso: Date.today)
    assert_not articulo.valid?
    assert_includes articulo.errors[:portador], "must exist"
  end

  test "should return full name" do
    assert_equal "#{@articulo.marca} #{@articulo.modelo}", @articulo.full_name
  end

  test "should destroy associated transferencias" do
    assert_difference('Transferencia.count', -@articulo.transferencias.count) do
      @articulo.destroy
    end
  end
end
