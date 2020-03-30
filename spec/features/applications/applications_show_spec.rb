require "rails_helper"

RSpec.describe "Application show page" do
  before :each do
    Shelter.destroy_all
    Pet.destroy_all
    @shelter_1 = Shelter.create!(name: "Denver Animal Shelter",
                              address: "500 Invisible St.",
                              city: "Denver",
                              state: "Colorado",
                              zip: "80201")

    @pet_1 = Pet.create(image: 'app/assets/images/border_collie.jpg',
                    name: 'Rover',
                    age: 3,
                    sex: "Male",
                    shelter: @shelter_1,
                    description: "He's a biter.",
                    status: "adoptable")

    @pet_2 = Pet.create(image: 'app/assets/images/border_collie.jpg',
                    name: 'George',
                    age: 3,
                    sex: "Male",
                    shelter: @shelter_1,
                    description: "He's a biter.",
                    status: "adoptable")

    @application = Application.create(
                    name: "John Wick",
                    address: "450 S. Cherry St.",
                    city: "Aldoran",
                    state: "CO",
                    zip: "19999",
                    phone_number: "8007891234",
                    description: "I have a big yard")

    ApplicationPet.create(application: @application, pet: @pet_1)
    ApplicationPet.create(application: @application, pet: @pet_2)

  end

  it "has application info displayed" do
    visit "/applications/#{@application.id}"

    expect(page).to have_content("John Wick")
    expect(page).to have_content("450 S. Cherry St.")
    expect(page).to have_content("Aldoran")
    expect(page).to have_content("CO")
    expect(page).to have_content("19999")
    expect(page).to have_content("8007891234")
    expect(page).to have_content("I have a big yard")

    within "#pet-#{@pet_1.id}" do
      click_link "Rover"
      expect(page).to have_current_path("/pets/#{@pet_1.id}")
    end
    visit "/applications/#{@application.id}"

    within "#pet-#{@pet_2.id}" do
      click_link "George"
      expect(page).to have_current_path("/pets/#{@pet_2.id}")
    end
    visit "/applications/#{@application.id}"

  end

  it "can approve pet applications" do
    visit "/applications/#{@application.id}"

    within "#pet-#{@pet_1.id}" do
      click_link "Approve"
    end

    expect(page).to have_current_path("/pets/#{@pet_1.id}")

    expect(page).to have_content("Pending")
    expect(page).to have_content("John Wick")
  end
end

# User Story 22, Approving an Application
#
# As a visitor
# When I visit an application's show page
# For every pet that the application is for, I see a link to approve the application for that specific pet
# When I click on a link to approve the application for one particular pet
# I'm taken back to that pet's show page
# And I see that the pets status has changed to 'pending'
# And I see text on the page that says who this pet is on hold for (Ex: "On hold for John Smith", given John Smith is the name on the application that was just accepted)
