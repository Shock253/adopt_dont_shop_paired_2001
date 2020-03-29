require 'rails_helper'

RSpec.describe "Favorites delete action" do
  it "can remove pet from favorites list" do
    shelter_1 = Shelter.create!(name: "Denver Animal Shelter",
                          address: "500 Invisible St.",
                          city: "Denver",
                          state: "Colorado",
                          zip: "80201")

    shelter_2 = Shelter.create!(name: "Denver Animal Shelter",
                              address: "500 Invisible St.",
                              city: "Denver",
                              state: "Colorado",
                              zip: "80201")

    pet_1 = Pet.create(image: 'app/assets/images/border_collie.jpg',
                    name: 'Fred',
                    age: 3,
                    sex: "Male",
                    shelter: shelter_1,
                    description: "He's a biter.",
                    status: "Pending")

    pet_2 = Pet.create(image: 'app/assets/images/border_collie.jpg',
                    name: 'Rover',
                    age: 3,
                    sex: "Male",
                    shelter: shelter_2,
                    description: "He's a biter.",
                    status: "Pending")

    visit "/pets/#{pet_1.id}"
    click_button('Add to Favorites')
    visit "/pets/#{pet_2.id}"
    click_button('Add to Favorites')
    visit "/favorites"

    within "#pet-#{pet_1.id}" do
      expect(page).to have_content('Fred')
      expect(page).to have_button("Remove from Favorites")
      click_button("Remove from Favorites")
    end

    expect(page).to have_current_path("/favorites")
    expect(page).to_not have_content("Fred")
    expect(page).to have_content("Favorite Pets: 1")

    within "#pet-#{pet_2.id}" do
      expect(page).to have_button('Remove from Favorites')
    end
  end
end
