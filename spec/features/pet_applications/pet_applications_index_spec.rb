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

    visit "/pets/#{@pet_1.id}"
    click_button('Add to Favorites')
    visit "/applications/new"

    within("#pet-#{@pet_1.id}") do
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

    visit "/pets/#{@pet_1.id}"
    click_button('Add to Favorites')
    visit "/applications/new"

    within("#pet-#{@pet_1.id}") do
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
  end

  it "displays a list of all applicants for that pet" do
    visit "/pets/#{@pet_1.id}"
    click_link('View All Applications for This Pet')
    expect(page).to have_current_path("/applications/#{@pet_1.id}")
    expect(page).to have_content("John Wick")
    expect(page).to have_content("Luke Skywalker") #need to be links
  end

  it "displays a no applications for this pet message" do
    visit "/pets/#{@pet_2.id}"
    click_link('View All Applications for This Pet')
    expect(page).to have_current_path("/applications/#{@pet_2.id}")
    expect(page).to have_content("#{@pet_2.name} currently has no applications to adopt them!")
  end
end
