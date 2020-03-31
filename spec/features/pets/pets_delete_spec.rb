require 'rails_helper'

RSpec.describe "pets show page" do
  it "can delete pets by id" do
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

    click_link('Delete Pet')
    expect(page).to have_current_path("/pets")
    expect(page).to_not have_content("Rover")
  end

  it "can not delete pet if it is approved by an application" do
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
                    status: "adoptable")

    application = Application.create(name: "John Wick",
                                      address: "450 S. Cherry St.",
                                      city: "Aldoran",
                                      state: "CO",
                                      zip: "19999",
                                      phone_number: "8007891234",
                                      description: "I have a big yard")
    ApplicationPet.create(application: application, pet: pet_1)

    visit "/applications/#{application.id}"
    within "#pet-#{pet_1.id}" do
      click_link "Approve #{pet_1.name} for Adoption"
    end

    expect(page).to have_current_path("/pets/#{pet_1.id}")
    expect(page).to_not have_link('Delete Pet')
  end

  it "deletes a pet and removes it from favorites" do
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
    click_link('Delete Pet')
    expect(page).to have_content("Favorite Pets: 0")
  end
end
