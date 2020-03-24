require 'rails_helper'

RSpec.describe "Shelter delete functionality", type: :feature do
  it "can delete individual shelters" do
    shelter_1 = Shelter.create!(name: "Denver Animal Shelter",
                               address: "500 Invisible St.",
                               city: "Denver",
                               state: "Colorado",
                               zip: "80201")
    visit "/shelters/#{shelter_1.id}"
    expect(page).to have_link('Delete Shelter')

    click_link('Delete Shelter')
    expect(page).to have_current_path('/shelters')
    expect(page).to_not have_content("Denver Animal Shelter")
  end
end
