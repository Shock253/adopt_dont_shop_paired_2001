require 'rails_helper'

RSpec.describe "pets create page", type: :feature do
  it "can create new pets" do
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
    visit "/shelters/#{shelter_1.id}"

    click_link("Shelter Pets")

    expect(page).to have_css("img[src*='#{pet_1.image}']")
    expect(page).to have_current_path("/shelters/#{shelter_1.id}/pets")
    expect(page).to have_content(pet_1.name)
    expect(page).to have_content(pet_1.age)
    expect(page).to have_content(pet_1.sex)
    click_link("Create Pet")
    expect(page). to have_current_path("/shelters/#{shelter_1.id}/pets/new")

    fill_in "name", with: "Johnny"
    fill_in "age", with: "11"
    fill_in "sex", with: "Female"
    fill_in "description", with: "Cute hedgehog"
    fill_in "image", with: "https://media1.fdncms.com/sevendaysvt/imager/u/blog/28218452/animalissue2-1-43f2a278bdb53e2e.jpg?cb=1565792097"

    click_button('Create Pet')

    expect(page).to have_current_path("/shelters/#{shelter_1.id}/pets")
    expect(page).to have_content("Johnny")
    expect(page).to have_content("11")
    expect(page).to have_content("Female")
    expect(page).to have_content("Cute hedgehog")
    expect(page).to have_content("Adoptable")
    expect(page).to have_css("img[src*='https://media1.fdncms.com/sevendaysvt/imager/u/blog/28218452/animalissue2-1-43f2a278bdb53e2e.jpg?cb=1565792097']")
  end

  it "displays a flash message if required fields are missing" do
    shelter_1 = Shelter.create!(name: "Denver Animal Shelter",
                               address: "500 Invisible St.",
                               city: "Denver",
                               state: "Colorado",
                               zip: "80201")

    visit "/shelters/#{shelter_1.id}/pets"
    click_link("Create Pet")

    fill_in "name", with: ""
    fill_in "age", with: ""
    fill_in "sex", with: "Female"
    fill_in "description", with: "Cute hedgehog"
    fill_in "image", with: "https://media1.fdncms.com/sevendaysvt/imager/u/blog/28218452/animalissue2-1-43f2a278bdb53e2e.jpg?cb=1565792097"
    click_button("Create Pet")

    expect(page).to have_current_path("/shelters/#{shelter_1.id}/pets/new")
    expect(page).to have_content("Required fields are missing, please enter all information required.")
  end
end
