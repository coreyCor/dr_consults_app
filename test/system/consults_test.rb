require "application_system_test_case"

class ConsultsTest < ApplicationSystemTestCase
  setup do
    @consult = consults(:one)
  end

  test "visiting the index" do
    visit consults_url
    assert_selector "h1", text: "Consults"
  end

  test "should create consult" do
    visit consults_url
    click_on "New consult"

    fill_in "Asked by", with: @consult.asked_by
    fill_in "Assigned to", with: @consult.assigned_to
    fill_in "Body", with: @consult.body
    fill_in "Status", with: @consult.status
    fill_in "Title", with: @consult.title
    click_on "Create Consult"

    assert_text "Consult was successfully created"
    click_on "Back"
  end

  test "should update Consult" do
    visit consult_url(@consult)
    click_on "Edit this consult", match: :first

    fill_in "Asked by", with: @consult.asked_by
    fill_in "Assigned to", with: @consult.assigned_to
    fill_in "Body", with: @consult.body
    fill_in "Status", with: @consult.status
    fill_in "Title", with: @consult.title
    click_on "Update Consult"

    assert_text "Consult was successfully updated"
    click_on "Back"
  end

  test "should destroy Consult" do
    visit consult_url(@consult)
    click_on "Destroy this consult", match: :first

    assert_text "Consult was successfully destroyed"
  end
end
