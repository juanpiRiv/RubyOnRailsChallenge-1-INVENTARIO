require "test_helper"

class TransferenciaTest < ActiveSupport::TestCase
  test "no deberia guardar una transferencia sin articulo" do
    transferencia = Transferencia.new(persona: personas(:one), fecha: Date.today)
    assert_not transferencia.save, "Guardó la transferencia sin un artículo"
  end

  test "no deberia guardar una transferencia sin persona" do
    transferencia = Transferencia.new(articulo: articulos(:one), fecha: Date.today)
    assert_not transferencia.save, "Guardó la transferencia sin una persona"
  end

  test "deberia guardar una transferencia valida" do
    transferencia = Transferencia.new(articulo: articulos(:one), persona: personas(:one), fecha: Date.today)
    assert transferencia.save, "No guardó una transferencia válida"
  end
end
