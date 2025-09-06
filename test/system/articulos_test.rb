require "application_system_test_case"

class ArticulosTest < ApplicationSystemTestCase
  setup do
    @articulo = articulos(:one)
  end

  test "visiting the index" do
    visit articulos_url
    assert_selector "h1", text: "Articulos"
  end

  test "should create articulo" do
    visit articulos_url
    click_on "New articulo"

    fill_in "Fecha ingreso", with: @articulo.fecha_ingreso
    fill_in "Marca", with: @articulo.marca
    fill_in "Modelo", with: @articulo.modelo
    fill_in "Portador", with: @articulo.portador_id
    click_on "Create Articulo"

    assert_text "Articulo was successfully created"
    click_on "Back"
  end

  test "should update Articulo" do
    visit articulo_url(@articulo)
    click_on "Edit this articulo", match: :first

    fill_in "Fecha ingreso", with: @articulo.fecha_ingreso
    fill_in "Marca", with: @articulo.marca
    fill_in "Modelo", with: @articulo.modelo
    fill_in "Portador", with: @articulo.portador_id
    click_on "Update Articulo"

    assert_text "Articulo was successfully updated"
    click_on "Back"
  end

  test "should destroy Articulo" do
    visit articulo_url(@articulo)
    click_on "Destroy this articulo", match: :first

    assert_text "Articulo was successfully destroyed"
  end
end
