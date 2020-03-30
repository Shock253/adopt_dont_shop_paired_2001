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
                    status: "Pending")

    @pet_2 = Pet.create(image: 'app/assets/images/border_collie.jpg',
                    name: 'George',
                    age: 3,
                    sex: "Male",
                    shelter: @shelter_1,
                    description: "He's a biter.",
                    status: "Pending")

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

    click_link "Rover"
    expect(page).to have_current_path("/pets/#{@pet_1.id}")
    visit "/applications/#{@application.id}"

    click_link "George"
    expect(page).to have_current_path("/pets/#{@pet_2.id}")
    visit "/applications/#{@application.id}"

  end
end

# As a visitor
# When I visit an applications show page "/applications/:id"
# I can see the following:
# - name
# - address
# - city
# - state
# - zip
# - phone number
# - Description of why the applicant says they'd be a good home for this pet(s)
# - names of all pet's that this application is for (all names of pets should be links to their show page)
