require 'rails_helper'

RSpec.describe "Shelter delete functionality", type: :feature do
  it "can delete individual shelters" do
    shelter_1 = Shelter.create!(name: "Denver Animal Shelter",
                               address: "500 Invisible St.",
                               city: "Denver",
                               state: "Colorado",
                               zip: "80201")

   pet_1 = shelter_1.pets.create(image: 'app/assets/images/border_collie.jpg',
                  name: 'Rover',
                  age: 3,
                  sex: "Male",
                  description: "He's a biter.",
                  status: "adoptable")

    visit "/shelters/#{shelter_1.id}"
    expect(page).to have_link('Delete Shelter')

    click_link('Delete Shelter')
    expect(page).to have_current_path('/shelters')
    expect(page).to_not have_content("Denver Animal Shelter")
    visit "/pets"
    expect(page).to_not have_css("#pet-#{pet_1.id}")
  end

  it "when I try to delete a shelter with pending adoptions,
  I see a flash message indicating that the shelter cannot be deleted" do
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

  application = Application.create(
                 name: "John Wick",
                 address: "450 S. Cherry St.",
                 city: "Aldoran",
                 state: "CO",
                 zip: "19999",
                 phone_number: "8007891234",
                 description: "I have a big yard")

  application_pet = ApplicationPet.create(application: application, pet: pet_1)
  application_pet.status = "Approved"
  application_pet.save

  visit "/shelters/#{shelter_1.id}"
  expect(page).to have_link('Delete Shelter')

  click_link('Delete Shelter')
  expect(page).to have_current_path("/shelters/#{shelter_1.id}")
  expect(page).to have_content("Could not delete shelter, shelter has pending adoptions")
  end
end

#
# User Story 26, Shelters with Pets that have pending status cannot be Deleted
#
# As a visitor
# If a shelter has approved applications for any of their pets
# I can not delete that shelter
# Either:
# - there is no button visible for me to delete the shelter
# - if I click on the delete link for deleting a shelter, I see a flash message indicating that the shelter can not be deleted.
