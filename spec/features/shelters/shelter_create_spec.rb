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

  it "can flash messages for incomplete data" do
    visit '/shelters/new'

    fill_in "State", with: "Colorado"
    fill_in "Zip", with: "90000"
    click_button('Create Shelter')

    expect(page).to have_current_path("/shelters/new")
    expect(page).to have_content("Name can't be blank, Address can't be blank, and City can't be blank")

    fill_in "name", with: "Hedgehog Hospital"
    fill_in "Address", with: "99 Thorn Rd."
    fill_in "Zip", with: "90000"
    click_button('Create Shelter')

    expect(page).to have_current_path("/shelters/new")
    expect(page).to have_content("City can't be blank and State can't be blank")


    fill_in "name", with: "Hedgehog Hospital"
    fill_in "Address", with: "99 Thorn Rd."
    fill_in "State", with: "Colorado"
    fill_in "Zip", with: "90000"
    click_button('Create Shelter')

    expect(page).to have_current_path("/shelters/new")
    expect(page).to have_content("City can't be blank")
  end
end
