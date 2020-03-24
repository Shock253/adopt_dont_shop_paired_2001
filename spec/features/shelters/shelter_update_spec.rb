require 'rails_helper'

RSpec.describe "shelter update functionality" do
  it "can update shelter info" do
    shelter_1 = Shelter.create(name: "Denver Animal Shelter",
                               address: "500 Invisible St.",
                               city: "Denver",
                               state: "Colorado",
                               zip: "80201")
    visit "/shelters/#{shelter_1.id}"
    click_link("Update Shelter")

    fill_in "name", with: "Hedgehog Hospital"
    fill_in "Address", with: "99 Thorn Rd."
    fill_in "City", with: "Fort Collins"
    fill_in "State", with: "Colorado"
    fill_in "Zip", with: "90000"
    click_button('Update Shelter')
    expect(page).to have_current_path("/shelters/#{shelter_1.id}")
    expect(page).to have_content("Hedgehog Hospital")
    expect(page).to have_content("99 Thorn Rd.")
    expect(page).to have_content("Fort Collins")
    expect(page).to have_content("Colorado")
    expect(page).to have_content("90000")
  end

  it "can link to pets index page" do
    shelter_1 = Shelter.create(name: "Denver Animal Shelter",
                               address: "500 Invisible St.",
                               city: "Denver",
                               state: "Colorado",
                               zip: "80201")
    visit "/shelters/#{shelter_1.id}/edit"
    expect(page).to have_link("All Pets")
    click_link("All Pets")
    expect(page).to have_current_path("/pets")
  end

  it "can link to shelters index page" do
    shelter_1 = Shelter.create(name: "Denver Animal Shelter",
                               address: "500 Invisible St.",
                               city: "Denver",
                               state: "Colorado",
                               zip: "80201")
    visit "/shelters/#{shelter_1.id}/edit"
    expect(page).to have_link("All Shelters")
    click_link("All Shelters")
    expect(page).to have_current_path("/shelters")
  end
end
