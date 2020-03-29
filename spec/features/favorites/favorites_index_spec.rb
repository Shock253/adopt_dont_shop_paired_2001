require 'rails_helper'

RSpec.describe "Favorites index page" do
  it "can show all favorited pets" do
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
                    name: 'Rover',
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
      expect(page).to have_link("Rover")
      expect(page).to have_css("img[src*='app/assets/images/border_collie.jpg']")
      click_link("Rover")
    end
    expect(page).to have_current_path("/pets/#{pet_1.id}")

    visit "/favorites"
    within "#pet-#{pet_2.id}" do
      expect(page).to have_link("Rover")
    end
  end

  it "will display no pets message when there are no favorited pets" do
    visit "/favorites"
    expect(page).to have_content("No pets are currently favorited!")
  end

  it "can remove all pets with remove all pets link" do
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
                    name: 'Rover',
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
    expect(page).to have_link('Remove All Favorites')
    click_link('Remove All Favorites')
    expect(page).to have_current_path("/favorites")
    expect(page).to have_content("No pets are currently favorited!")
    expect(page).to have_content("Favorite Pets: 0")
  end
end
