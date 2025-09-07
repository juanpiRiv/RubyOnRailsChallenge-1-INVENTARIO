require "test_helper"

class TransferenciasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @transferencia = transferencias(:one)
  end

  test "should get index" do
    get transferencias_url
    assert_response :success
  end

  test "should get new" do
    get new_transferencia_url
    assert_response :success
  end

  test "should create transferencia" do
    articulo = articulos(:one)
    portador_anterior_id = articulo.portador_id
    nuevo_portador = personas(:two)

    assert_difference("Transferencia.count") do
      post transferencias_url, params: { transferencia: { articulo_id: articulo.id, fecha: Date.today, nuevo_portador_id: nuevo_portador.id } }
    end

    assert_redirected_to transferencia_url(Transferencia.last)
    assert_equal nuevo_portador.id, articulo.reload.portador_id
  end

  test "should show transferencia" do
    get transferencia_url(@transferencia)
    assert_response :success
  end

  test "should get edit" do
    get edit_transferencia_url(@transferencia)
    assert_response :success
  end

  test "should update transferencia" do
    # Asegurarse de que el nuevo portador sea diferente al portador anterior del fixture
    nuevo_portador_para_update = personas(:two) # personas(:one) es el portador_anterior del fixture :one
    patch transferencia_url(@transferencia), params: { transferencia: { articulo_id: @transferencia.articulo_id, fecha: @transferencia.fecha, nuevo_portador_id: nuevo_portador_para_update.id } }
    assert_redirected_to transferencia_url(@transferencia)
    assert_equal nuevo_portador_para_update.id, @transferencia.reload.nuevo_portador_id
  end

  test "should destroy transferencia" do
    assert_difference("Transferencia.count", -1) do
      delete transferencia_url(@transferencia)
    end

    assert_redirected_to transferencias_url
  end
end
