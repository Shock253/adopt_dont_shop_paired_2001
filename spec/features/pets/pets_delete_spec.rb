require 'rails_helper'

RSpec.describe "pets show page" do
  it "can delete pets by id" do
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

    click_link('Delete Pet')
    expect(page).to have_current_path("/pets")
    expect(page).to_not have_content("Rover")
  end
end
