require 'rails_helper'

RSpec.describe "pet show page", type: :feature do
  it "can show individual pets by id" do
    shelter_1 = Shelter.create!(name: "Denver Animal Shelter",
                               address: "500 Invisible St.",
                               city: "Denver",
                               state: "Colorado",
                               zip: "80201")

    pet = Pet.create!(image: 'app/assets/images/border_collie.jpg',
                     name: 'Rover',
                     age: 3,
                     sex: "Male",
                     shelter: shelter_1,
                     description: "Great Dog",
                     status: "Adoptable")

    visit "pets/#{pet.id}"

    expect(page).to have_css("img[src*='#{pet.image}']")
    expect(page).to have_content(pet.name)
    expect(page).to have_content(pet.age)
    expect(page).to have_content(pet.sex)
    expect(page).to have_content(pet.description)
    expect(page).to have_content(pet.status)
  end

  it "can link to itself" do
    shelter_1 = Shelter.create!(name: "Denver Animal Shelter",
                               address: "500 Invisible St.",
                               city: "Denver",
                               state: "Colorado",
                               zip: "80201")

    pet = Pet.create!(image: 'app/assets/images/border_collie.jpg',
                     name: 'Rover',
                     age: 3,
                     sex: "Male",
                     shelter: shelter_1,
                     description: "Great Dog",
                     status: "Adoptable")

    visit "pets/#{pet.id}"
    expect(page).to have_link("#{pet.name}")
    click_link("#{pet.name}")
    expect(page).to have_current_path("/pets/#{pet.id}")
  end

  it "has a link to change adoptable pets adoption status to pending" do
    shelter_1 = Shelter.create!(name: "Denver Animal Shelter",
                               address: "500 Invisible St.",
                               city: "Denver",
                               state: "Colorado",
                               zip: "80201")

    pet = Pet.create!(image: 'app/assets/images/border_collie.jpg',
                     name: 'Rover',
                     age: 3,
                     sex: "Male",
                     shelter: shelter_1,
                     description: "Great Dog",
                     status: "Adoptable")

    visit "pets/#{pet.id}"
    click_link("Change to Adoption Pending")
    expect(page).to have_content("Pending Adoption")
  end

  it "has a link to change pending pets adoption status to adoptable" do
    shelter_1 = Shelter.create!(name: "Denver Animal Shelter",
                               address: "500 Invisible St.",
                               city: "Denver",
                               state: "Colorado",
                               zip: "80201")

    pet = Pet.create!(image: 'app/assets/images/border_collie.jpg',
                     name: 'Rover',
                     age: 3,
                     sex: "Male",
                     shelter: shelter_1,
                     description: "Great Dog",
                     status: "Pending Adoption")

    visit "pets/#{pet.id}"
    click_link("Change to Adoptable")
    expect(page).to have_content("Adoptable")
  end

  it "has a button to add pets to favorite pets" do
    shelter_1 = Shelter.create!(name: "Denver Animal Shelter",
                               address: "500 Invisible St.",
                               city: "Denver",
                               state: "Colorado",
                               zip: "80201")

    pet = Pet.create!(image: 'app/assets/images/border_collie.jpg',
                     name: 'Rover',
                     age: 3,
                     sex: "Male",
                     shelter: shelter_1,
                     description: "Great Dog",
                     status: "Pending Adoption")
    visit "/pets/#{pet.id}"
    expect(page).to have_button('Add to Favorites')
    click_button('Add to Favorites')
    expect(page).to have_current_path("/pets/#{pet.id}")
    expect(page).to have_content("Pet successfully added to Favorites!")
    within(".nav") do
      expect(page).to have_content("Favorite Pets: 1")
    end
  end

  it "cannot favorite a pet more than once" do
    shelter_1 = Shelter.create!(name: "Denver Animal Shelter",
                               address: "500 Invisible St.",
                               city: "Denver",
                               state: "Colorado",
                               zip: "80201")

    pet = Pet.create!(image: 'app/assets/images/border_collie.jpg',
                     name: 'Rover',
                     age: 3,
                     sex: "Male",
                     shelter: shelter_1,
                     description: "Great Dog",
                     status: "Pending Adoption")

     visit "/pets/#{pet.id}"
     click_button('Add to Favorites')

     expect(page).not_to have_button('Add to Favorites')

     expect(page).to have_button('Remove from Favorites')
     click_button('Remove from Favorites')

     expect(page).to have_current_path("/pets/#{pet.id}")
     expect(page).to have_content("Pet successfully removed from Favorites")

     expect(page).to have_button('Add to Favorites')
     within(".nav") do
       expect(page).to have_content("Favorite Pets: 0")
     end
  end

  it "can link to applications index page" do
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
    visit "/applications/new"

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

    visit "/pets/#{pet_1.id}"
    click_button('Add to Favorites')
    visit "/applications/new"

    within("#pet-#{pet_1.id}") do
      check "pet_ids_"
    end

    fill_in "name", with: "Luke Skywalker"
    fill_in "address", with: "450 S. Cherry St."
    fill_in "city", with: "Aldoran"
    fill_in "state", with: "CO"
    fill_in "zip", with: "19999"
    fill_in "phone_number", with: "8007891234"
    fill_in "description", with: "I have a big yard"
    click_button "Submit Application"

    visit "/pets/#{pet_1.id}"
    expect(page).to have_link('View All Applications for This Pet')
    click_link('View All Applications for This Pet')
    expect(page).to have_current_path("/applications/#{pet_1.id}")
  end
end
