require "test_helper"

class TransferenciaTest < ActiveSupport::TestCase
  setup do
    @articulo = articulos(:one)
    @portador_anterior = personas(:one)
    @nuevo_portador = personas(:two)
  end

  test "should be valid" do
    transferencia = Transferencia.new(articulo: @articulo, portador_anterior: @portador_anterior, nuevo_portador: @nuevo_portador, fecha: Date.today)
    assert transferencia.valid?
  end

  test "should require articulo" do
    transferencia = Transferencia.new(portador_anterior: @portador_anterior, nuevo_portador: @nuevo_portador, fecha: Date.today)
    assert_not transferencia.valid?
    assert_includes transferencia.errors[:articulo], "must exist"
  end

  test "should require portador_anterior" do
    transferencia = Transferencia.new(articulo: @articulo, nuevo_portador: @nuevo_portador, fecha: Date.today)
    assert_not transferencia.valid?
    assert_includes transferencia.errors[:portador_anterior], "must exist"
  end

  test "should require nuevo_portador" do
    transferencia = Transferencia.new(articulo: @articulo, portador_anterior: @portador_anterior, fecha: Date.today)
    assert_not transferencia.valid?
    assert_includes transferencia.errors[:nuevo_portador], "must exist"
  end

  test "should require fecha" do
    transferencia = Transferencia.new(articulo: @articulo, portador_anterior: @portador_anterior, nuevo_portador: @nuevo_portador)
    assert_not transferencia.valid?
    assert_includes transferencia.errors[:fecha], "can't be blank"
  end

  test "portador_anterior should not be the same as nuevo_portador" do
    transferencia = Transferencia.new(articulo: @articulo, portador_anterior: @portador_anterior, nuevo_portador: @portador_anterior, fecha: Date.today)
    assert_not transferencia.valid?
    assert_includes transferencia.errors[:nuevo_portador], "no puede ser el mismo que el portador anterior"
  end
end
