require 'rails_helper'

RSpec.describe "Shelter reviews create page" do
  it "can create shelter review with image" do
    shelter_1 = Shelter.create!(name: "Denver Animal Shelter",
                               address: "500 Invisible St.",
                               city: "Denver",
                               state: "Colorado",
                               zip: "80201")

    visit "/shelters/#{shelter_1.id}/reviews/new"

    fill_in "title", with: "Horrible Shelter"
    fill_in "rating", with: "1/5"
    fill_in "content", with: "They stole my dog!"
    fill_in "image", with: "https://i.ytimg.com/vi/tLY-qCnnPQM/maxresdefault.jpg"

    click_button "Post Review"

    expect(page).to have_current_path("/shelters/#{shelter_1.id}")

    expect(page).to have_content("Horrible Shelter")
    expect(page).to have_content("1/5")
    expect(page).to have_content("They stole my dog!")
    expect(page).to have_css("img[src*='https://i.ytimg.com/vi/tLY-qCnnPQM/maxresdefault.jpg']")
  end

  it "can create shelter review without image" do
    shelter_1 = Shelter.create!(name: "Denver Animal Shelter",
                               address: "500 Invisible St.",
                               city: "Denver",
                               state: "Colorado",
                               zip: "80201")

    visit "/shelters/#{shelter_1.id}/reviews/new"

    fill_in "title", with: "Horrible Shelter"
    fill_in "rating", with: "1/5"
    fill_in "content", with: "They stole my dog!"

    click_button "Post Review"

    expect(page).to have_current_path("/shelters/#{shelter_1.id}")

    expect(page).to have_content("Horrible Shelter")
    expect(page).to have_content("1/5")
    expect(page).to have_content("They stole my dog!")
  end

  it "can not create shelter review without correct values" do
    shelter_1 = Shelter.create!(name: "Denver Animal Shelter",
                               address: "500 Invisible St.",
                               city: "Denver",
                               state: "Colorado",
                               zip: "80201")

    visit "/shelters/#{shelter_1.id}/reviews/new"

    fill_in "title", with: ""
    fill_in "rating", with: ""
    fill_in "content", with: ""

    click_button "Post Review"

    expect(page).to have_content("Could not create shelter: Please make sure to enter title, rating, and content")
    expect(page).to have_current_path("/shelters/#{shelter_1.id}/reviews/new")
  end
end

# User Story 4, Shelter Review Creation, cont.
#
# As a visitor,
# When I fail to enter a title, a rating, and/or content in the new shelter review form, but still try to submit the form
# I see a flash message indicating that I need to fill in a title, rating, and content in order to submit a shelter review
# And I'm returned to the new form to create a new review
