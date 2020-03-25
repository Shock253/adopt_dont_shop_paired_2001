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

    within ("#review-#{review_1.id}") do
      expect(page).to have_content("Horrible Shelter")
      expect(page).to have_content("1/5")
      expect(page).to have_content("They stole my dog!")
      expect(page).to have_content("https://i.ytimg.com/vi/tLY-qCnnPQM/maxresdefault.jpg")
    end
  end
end

# User Story 3, Shelter Review Creation
#
# As a visitor,
# When I visit a shelter's show page
# I see a link to add a new review for this shelter.
# When I click on this link, I am taken to a new review path
# On this new page, I see a form where I must enter:
# - title
# - rating
# - content
# I also see a field where I can enter an optional image (web address)
# When the form is submitted, I should return to that shelter's show page
# and I can see my new review
