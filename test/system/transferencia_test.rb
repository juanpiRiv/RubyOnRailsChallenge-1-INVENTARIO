require "application_system_test_case"

class TransferenciaTest < ApplicationSystemTestCase
  setup do
    @transferencium = transferencia(:one)
  end

  test "visiting the index" do
    visit transferencia_url
    assert_selector "h1", text: "Transferencia"
  end

  test "should create transferencium" do
    visit transferencia_url
    click_on "New transferencium"

    click_on "Create Transferencium"

    assert_text "Transferencium was successfully created"
    click_on "Back"
  end

  test "should update Transferencium" do
    visit transferencium_url(@transferencium)
    click_on "Edit this transferencium", match: :first

    click_on "Update Transferencium"

    assert_text "Transferencium was successfully updated"
    click_on "Back"
  end

  test "should destroy Transferencium" do
    visit transferencium_url(@transferencium)
    click_on "Destroy this transferencium", match: :first

    assert_text "Transferencium was successfully destroyed"
  end
end
