require 'rails_helper'

RSpec.describe "Shelter review delete" do
  it "can delete shelter reviews " do
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
    expect(page).to have_link("Delete Review")
    click_link('Delete Review')
    expect(page).to have_current_path("/shelters/#{shelter_1.id}")
    expect(page).to_not have_content("Horrible Shelter")
  end
end
