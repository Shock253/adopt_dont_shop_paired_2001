require 'rails_helper'

RSpec.describe "pets show page", type: :feature do
  it "can update pet info" do
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

    click_link 'Update Pet'
    expect(page).to have_current_path("/pets/#{pet_1.id}/edit")
    expect(find_field('Name:').value).to eq "Rover"
    expect(find_field('Age:').value).to eq "3"
    expect(find_field('Sex:').value).to eq "Male"
    expect(find_field('Description:').value).to eq "He's a biter."
    expect(find_field('Image:').value).to eq "app/assets/images/border_collie.jpg"

    fill_in "name", with: "Johnny"
    fill_in "age", with: "11"
    fill_in "sex", with: "Female"
    fill_in "description", with: "Cute hedgehog"
    fill_in "image", with: "https://media1.fdncms.com/sevendaysvt/imager/u/blog/28218452/animalissue2-1-43f2a278bdb53e2e.jpg?cb=1565792097"
    click_button('Update Pet')
    expect(page).to have_current_path("/pets/#{pet_1.id}")
    expect(page).to have_content("Johnny")
    expect(page).to have_content("11")
    expect(page).to have_content("Female")
    expect(page).to have_content("Cute hedgehog")
    expect(page).to have_content("Pending")
    expect(page).to have_css("img[src*='https://media1.fdncms.com/sevendaysvt/imager/u/blog/28218452/animalissue2-1-43f2a278bdb53e2e.jpg?cb=1565792097']")
  end
  it "can link to pets index" do
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
    visit "/pets/#{pet_1.id}/edit"
    expect(page).to have_link("All Pets")
    click_link("All Pets")
    expect(page).to have_current_path("/pets")
  end

  it "can link to shelters index page" do
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
                    
    visit "/pets/#{pet_1.id}/edit"
    expect(page).to have_link("All Shelters")
    click_link("All Shelters")
    expect(page).to have_current_path("/shelters")
  end
end
