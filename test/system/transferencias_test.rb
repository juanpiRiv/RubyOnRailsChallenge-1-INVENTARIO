require "application_system_test_case"

class TransferenciasTest < ApplicationSystemTestCase
  setup do
    @transferencia = transferencias(:one)
  end

  test "visiting the index" do
    visit transferencias_url
    assert_selector "h1", text: "Transferencias"
  end

  test "should create transferencia" do
    visit transferencias_url
    click_on "New transferencia"

    fill_in "Articulo", with: @transferencia.articulo_id
    fill_in "Fecha", with: @transferencia.fecha
    fill_in "Persona", with: @transferencia.persona_id
    click_on "Create Transferencia"

    assert_text "Transferencia was successfully created"
    click_on "Back"
  end

  test "should update Transferencia" do
    visit transferencia_url(@transferencia)
    click_on "Edit this transferencia", match: :first

    fill_in "Articulo", with: @transferencia.articulo_id
    fill_in "Fecha", with: @transferencia.fecha
    fill_in "Persona", with: @transferencia.persona_id
    click_on "Update Transferencia"

    assert_text "Transferencia was successfully updated"
    click_on "Back"
  end

  test "should destroy Transferencia" do
    visit transferencia_url(@transferencia)
    click_on "Destroy this transferencia", match: :first

    assert_text "Transferencia was successfully destroyed"
  end
end
