require 'rails_helper'

RSpec.describe "Pet applications index page" do
  before :each do
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
                        age: 4,
                        sex: "Male",
                        shelter: @shelter_1,
                        description: "Great dog.",
                        status: "Adoptable")

    @application_1 = Application.create(
                    name: "John Wick",
                    address: "450 S. Cherry St.",
                    city: "Aldoran",
                    state: "CO",
                    zip: "19999",
                    phone_number: "8007891234",
                    description: "I have a big yard")

    @application_2 = Application.create(
                    name: "Luke Skywalker",
                    address: "450 S. Cherry St.",
                    city: "Aldoran",
                    state: "CO",
                    zip: "19999",
                    phone_number: "8007891234",
                    description: "I have a big yard")

    ApplicationPet.create(application: @application_1, pet: @pet_1)
    ApplicationPet.create(application: @application_2, pet: @pet_1)
  end

  it "displays a list of all applicants for that pet" do
    visit "/pets/#{@pet_1.id}"
    click_link('View All Applications for This Pet')
    expect(page).to have_current_path("/pets/#{@pet_1.id}/applications")
    expect(page).to have_link("John Wick")
    expect(page).to have_link("Luke Skywalker")

    click_link("John Wick")
    expect(page).to have_current_path "/applications/#{@application_1.id}"
    expect(page).to have_content("John Wick")

    visit "/pets/#{@pet_1.id}/applications"
    click_link("Luke Skywalker")
    expect(page).to have_current_path "/applications/#{@application_2.id}"
    expect(page).to have_content("Luke Skywalker")
  end

  it "displays a no applications for this pet message" do
    visit "/pets/#{@pet_2.id}"
    click_link('View All Applications for This Pet')
    expect(page).to have_current_path("/pets/#{@pet_2.id}/applications")
    expect(page).to have_content("#{@pet_2.name} currently has no applications to adopt them!")
  end
end
