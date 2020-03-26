require 'rails_helper'

RSpec.describe "Shelter's pets index", type: :feature do
  it "can show each pet that the shelter has" do
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
  end

  it "has a link to update each pet" do
    shelter_1 = Shelter.create!(name: "Denver Animal Shelter",
                               address: "500 Invisible St.",
                               city: "Denver",
                               state: "Colorado",
                               zip: "80201")

    pet = Pet.create!(image: 'https://image.shutterstock.com/z/stock-photo-attentive-border-collie-dog-lying-down-on-the-grass-on-a-sunny-d-593634296.jpg',
                     name: 'Rover',
                     age: 3,
                     sex: "Male",
                     shelter: shelter_1,
                     description: "Good dog, very active",
                     status: "Adoptable")

    visit "/shelters/#{shelter_1.id}/pets"
    expect(page).to have_link('Update Pet')
    click_link('Update Pet')
    expect(page).to have_current_path("/pets/#{pet.id}/edit")
  end

  it "has a link to delete each pet" do
    shelter_1 = Shelter.create!(name: "Denver Animal Shelter",
                               address: "500 Invisible St.",
                               city: "Denver",
                               state: "Colorado",
                               zip: "80201")

    pet = Pet.create!(image: 'https://image.shutterstock.com/z/stock-photo-attentive-border-collie-dog-lying-down-on-the-grass-on-a-sunny-d-593634296.jpg',
                     name: 'Rover',
                     age: 3,
                     sex: "Male",
                     shelter: shelter_1,
                     description: "Good dog, very active",
                     status: "Adoptable")

    visit "/shelters/#{shelter_1.id}/pets"
    expect(page).to have_link('Delete Pet')
    click_link('Delete Pet')
    expect(page).to have_current_path("/pets")
    expect(page).to_not have_content('Rover')
  end

  it "has a link to each pet's show page" do
    shelter_1 = Shelter.create!(name: "Denver Animal Shelter",
                               address: "500 Invisible St.",
                               city: "Denver",
                               state: "Colorado",
                               zip: "80201")

    pet = Pet.create!(image: 'https://image.shutterstock.com/z/stock-photo-attentive-border-collie-dog-lying-down-on-the-grass-on-a-sunny-d-593634296.jpg',
                     name: 'Rover',
                     age: 3,
                     sex: "Male",
                     shelter: shelter_1,
                     description: "Good dog, very active",
                     status: "Adoptable")

    visit "/shelters/#{shelter_1.id}/pets"
    expect(page).to have_link("#{pet.name}")
    click_link("#{pet.name}")
    expect(page).to have_current_path("/pets/#{pet.id}")
  end

  it "can show count of pets at the shelter" do
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

    pet_2 = Pet.create(image: 'app/assets/images/border_collie.jpg',
                    name: 'Rover',
                    age: 3,
                    sex: "Male",
                    shelter: shelter_1,
                    description: "He's a biter.",
                    status: "Pending")

    visit "/shelters/#{shelter_1.id}/pets"
    expect(page).to have_content "Pet Count:"
    expect(page).to have_content(2)
  end

  it "can sort pets by adoption status" do
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

    pet_2 = Pet.create(image: 'app/assets/images/border_collie.jpg',
                    name: 'Sam',
                    age: 3,
                    sex: "Male",
                    shelter: shelter_1,
                    description: "He's a biter.",
                    status: "Adoptable")

    visit "/shelters/#{shelter_1.id}/pets"
    first('.pet_link').click_link
    expect(page).to have_current_path("/pets/#{pet_2.id}")
  end

  it "can filter pets by adoption status" do
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
                    status: "Pending Adoption")

    pet_2 = Pet.create(image: 'app/assets/images/border_collie.jpg',
                    name: 'Sam',
                    age: 3,
                    sex: "Male",
                    shelter: shelter_1,
                    description: "He's a biter.",
                    status: "Adoptable")
    visit "/shelters/#{shelter_1.id}/pets"
    click_link("Adoptable Pets")
    expect(page).to have_current_path("/shelters/#{shelter_1.id}/pets?adoptable=true")
    expect(page).to have_content(pet_2.name)

    visit "/shelters/#{shelter_1.id}/pets"
    click_link("Pets Pending Adoption")
    expect(page).to have_current_path("/shelters/#{shelter_1.id}/pets?adoptable=false")
    expect(page).to have_content(pet_1.name)
  end
end
