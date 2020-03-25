require 'rails_helper'

RSpec.describe "Shelter reviews edit page" do
  it "can update shelter review" do
    shelter_1 = Shelter.create!(name: "Denver Animal Shelter",
                               address: "500 Invisible St.",
                               city: "Denver",
                               state: "Colorado",
                               zip: "80201")

    review1 = shelter_1.shelter_reviews.create!(title: "Horrible Shelter",
                                    rating: "1/5",
                                    content: "They stole my dog!",
                                    image: "https://i.ytimg.com/vi/tLY-qCnnPQM/maxresdefault.jpg")
    visit("/shelters/#{shelter_1.id}/reviews/#{review1.id}/edit")
    expect(find_field('Title:').value).to eq "Horrible Shelter"
    expect(find_field('Rating:').value).to eq "1/5"
    expect(find_field('Content:').value).to eq "They stole my dog!"
    expect(find_field('Image:').value).to eq "https://i.ytimg.com/vi/tLY-qCnnPQM/maxresdefault.jpg"

    fill_in "title", with: "Not so Bad"
    fill_in "rating", with: "4/5"
    fill_in "content", with: "I found my dog, they didn't lose him"
    click_button('Update Shelter Review')
    expect(page).to have_current_path("/shelters/#{shelter_1.id}")
    within("#review-#{review1.id}")
      expect(page).to have_content("Not so Bad")
  end
end
