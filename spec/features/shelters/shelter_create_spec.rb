require 'rails_helper'

RSpec.describe "shelter create page", type: :feature do
  it "can create new shelters" do
    visit '/shelters/new'

    fill_in "name", with: "Hedgehog Hospital"
    fill_in "Address", with: "99 Thorn Rd."
    fill_in "City", with: "Fort Collins"
    fill_in "State", with: "Colorado"
    fill_in "Zip", with: "90000"
    click_button('Create Shelter')

    expect(page).to have_current_path("/shelters")
    expect(page).to have_content("Hedgehog Hospital")
  end
end
