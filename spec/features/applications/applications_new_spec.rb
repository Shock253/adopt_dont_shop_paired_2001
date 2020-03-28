require 'rails_helper'

RSpec.describe "New Application form" do
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
    visit "/pets/#{@pet_1.id}"
    click_button('Add to Favorites')
    visit "/pets/#{@pet_2.id}"
    click_button('Add to Favorites')
  end

  it "can create a new application to adopt pets" do
    visit "/applications/new"

    within("#pet-#{@pet_1.id}") do
      check "pet_ids_"
    end

    within("#pet-#{@pet_2.id}") do
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
    expect(page).to have_current_path("/favorites")
    expect(page).to have_content("Application successfully submitted!")
    expect(page).to_not have_content("Rover")
    expect(page).to_not have_content("George")
    expect(page).to have_content("Favorite Pets: 0")
  end
end
