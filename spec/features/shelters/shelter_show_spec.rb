require 'rails_helper'

RSpec.describe "shelter id page", type: :feature do
  it "can display shelter information on id page" do
    shelter_1 = Shelter.create!(name: "Denver Animal Shelter",
                               address: "500 Invisible St.",
                               city: "Denver",
                               state: "Colorado",
                               zip: "80201")

  visit "/shelters/#{shelter_1.id}"

    expect(page).to have_content(shelter_1.name)
    expect(page).to have_content(shelter_1.address)
    expect(page).to have_content(shelter_1.city)
    expect(page).to have_content(shelter_1.state)
    expect(page).to have_content(shelter_1.zip)
  end

  it "can link to an edit page for the shelter id" do
    shelter_1 = Shelter.create!(name: "Denver Animal Shelter",
                               address: "500 Invisible St.",
                               city: "Denver",
                               state: "Colorado",
                               zip: "80201")
    visit "/shelters/#{shelter_1.id}"

    expect(page).to have_link("Update Shelter")

    click_link("Update Shelter")

    expect(page).to have_current_path("/shelters/#{shelter_1.id}/edit")
    expect(page).to have_content('Name:')
    expect(page).to have_content('Address:')
    expect(page).to have_content('City:')
    expect(page).to have_content('State:')
    expect(page).to have_content('Zip:')
  end

  it "can link to itself by shelter name" do
    shelter_1 = Shelter.create!(name: "Denver Animal Shelter",
                               address: "500 Invisible St.",
                               city: "Denver",
                               state: "Colorado",
                               zip: "80201")
    visit "/shelters/#{shelter_1.id}"
    expect(page).to have_link("#{shelter_1.name}")
    click_link("#{shelter_1.name}")
    expect(page).to have_current_path("/shelters/#{shelter_1.id}")
  end

  it "can link to pets index page" do
    shelter_1 = Shelter.create!(name: "Denver Animal Shelter",
                               address: "500 Invisible St.",
                               city: "Denver",
                               state: "Colorado",
                               zip: "80201")
    visit "/shelters/#{shelter_1.id}"
    expect(page).to have_link("All Pets")
    click_link("All Pets")
    expect(page).to have_current_path("/pets")
  end

  it "has a list of reviews for that shelter" do
    shelter_1 = Shelter.create!(name: "Denver Animal Shelter",
                               address: "500 Invisible St.",
                               city: "Denver",
                               state: "Colorado",
                               zip: "80201")

    review1 = shelter_1.shelter_reviews.create!(title: "Horrible Shelter",
                                    rating: "1/5",
                                    content: "They stole my dog!",
                                    image: "https://i.ytimg.com/vi/tLY-qCnnPQM/maxresdefault.jpg")

    review2 = shelter_1.shelter_reviews.create!(title: "Great Experience!",
                                    rating: "3/5",
                                    content: "Grabbed a new dog and ran away with it!",
                                    image: "https://i.ytimg.com/vi/tLY-qCnnPQM/maxresdefault.jpg")

    review3 = shelter_1.shelter_reviews.create!(title: "Horrible Shelter",
                                    rating: "1/5",
                                    content: "They stole my dog!")

    visit ("/shelters/#{shelter_1.id}")
    within("#review-#{review1.id}") do
      expect(page).to have_content(review1.title)
      expect(page).to have_content(review1.rating)
      expect(page).to have_content(review1.content)
      expect(page).to have_css("img[src*='https://i.ytimg.com/vi/tLY-qCnnPQM/maxresdefault.jpg']")
    end

    within("#review-#{review3.id}") do
      expect(page).to have_content(review3.title)
      expect(page).to have_content(review3.rating)
      expect(page).to have_content(review3.content)
    end
  end

  it "has a link to create a new review" do
    shelter_1 = Shelter.create!(name: "Denver Animal Shelter",
                               address: "500 Invisible St.",
                               city: "Denver",
                               state: "Colorado",
                               zip: "80201")

    visit("/shelters/#{shelter_1.id}")

    expect(page).to have_link("Post a Review")
    click_link "Post a Review"

    expect(page).to have_current_path("/shelters/#{shelter_1.id}/reviews/new")
  end

  it "has a link to edit each review next to the review" do
    shelter_1 = Shelter.create!(name: "Denver Animal Shelter",
                               address: "500 Invisible St.",
                               city: "Denver",
                               state: "Colorado",
                               zip: "80201")

    review1 = shelter_1.shelter_reviews.create!(title: "Horrible Shelter",
                                    rating: "1/5",
                                    content: "They stole my dog!",
                                    image: "https://i.ytimg.com/vi/tLY-qCnnPQM/maxresdefault.jpg")
     visit("/shelters/#{shelter_1.id}")
     within("#review-#{review1.id}")
      expect(page).to have_link("Edit Review")
      click_link("Edit Review")
      expect(page).to have_current_path("/shelters/#{shelter_1.id}/reviews/#{review1.id}/edit")
  end

  it "shows that shelter's statistics" do
    shelter_1 = Shelter.create!(name: "Denver Animal Shelter",
                               address: "500 Invisible St.",
                               city: "Denver",
                               state: "Colorado",
                               zip: "80201")

    review1 = shelter_1.shelter_reviews.create!(title: "Horrible Shelter",
                                   rating: "1/5",
                                   content: "They stole my dog!",
                                   image: "https://i.ytimg.com/vi/tLY-qCnnPQM/maxresdefault.jpg")

    review2 = shelter_1.shelter_reviews.create!(title: "Great Experience!",
                                   rating: "3/5",
                                   content: "Grabbed a new dog and ran away with it!",
                                   image: "https://i.ytimg.com/vi/tLY-qCnnPQM/maxresdefault.jpg")

    review3 = shelter_1.shelter_reviews.create!(title: "Horrible Shelter",
                                   rating: "1/5",
                                   content: "They stole my dog!")

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

    application = Application.create(
                   name: "John Wick",
                   address: "450 S. Cherry St.",
                   city: "Aldoran",
                   state: "CO",
                   zip: "19999",
                   phone_number: "8007891234",
                   description: "I have a big yard")

    ApplicationPet.create(application: application, pet: pet_1)
    ApplicationPet.create(application: application, pet: pet_2)

    visit "/shelters/#{shelter_1.id}"

    within "#statistics" do
      expect(page).to have_content("Pets: 2")
      expect(page).to have_content("Average Rating: 1.7")
      expect(page).to have_content("Current Applications: 1")
    end
  end
end
