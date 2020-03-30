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

  it "has a link to application" do
    shelter_1 = Shelter.create!(name: "Denver Animal Shelter",
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

    visit "/pets/#{pet_1.id}"
    click_button('Add to Favorites')
    visit "/favorites"
    expect(page).to have_link("Apply to Adopt")
    click_link("Apply to Adopt")
    expect(page).to have_current_path("/applications/new")
  end

  it "has a list of pets that have applications on them" do
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
                    name: 'John',
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

    click_link("Apply to Adopt")

    within("#pet-#{pet_1.id}") do
      check "pet_ids_"
    end

    fill_in "name", with: "John Wick"
    fill_in "address", with: "450 S. Cherry St."
    fill_in "city", with: "Aldoran"
    fill_in "state", with: "CO"
    fill_in "zip", with: "19999"
    fill_in "phone_number", with: "8007891234"
    fill_in "description", with: "I have a big yard"
    click_button "Submit Application"

    within("#pet-#{pet_2.id}") do
      expect(page).to have_content(pet_2.name)
    end

    within("#pets-with-applications") do
      expect(page).to have_content("Pets You Applied For")
      within("#pet-#{pet_1.id}") do
        expect(page).to have_link(pet_1.name)
        click_link(pet_1.name)
      end
    end

    expect(page).to have_current_path("/pets/#{pet_1.id}")
  end
end

# User Story 18, List of Pets that have applications on them
#
# As a visitor
# After one or more applications have been created
# When I visit the favorites index page
# I see a section on the page that has a list of all of the pets that have at least one application on them
# Each pet's name is a link to their show page
