require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  context "whenever I visit any page on the site" do
    before :each do
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

      @pages = [
          "/shelters",
          "/shelters/new",
          "/shelters/#{@shelter_1.id}",
          "/shelters/#{@shelter_1.id}/edit",
          "/shelters/#{@shelter_1.id}/pets",
          "/shelters/#{@shelter_1.id}/pets/new",
          "/pets",
          "/pets/#{@pet_1.id}",
          "/pets/#{@pet_1.id}/edit",
          "/favorites"
        ]
    end

    it "I can link to the shelters index page" do
      @pages.each do |path|
        visit path
        expect(page).to have_link("All Shelters")
        click_link("All Shelters")
        expect(page).to have_current_path("/shelters")
      end
    end

    it "I can link to pets index page" do
      @pages.each do |path|
        visit path
        expect(page).to have_link("All Pets")
        click_link("All Pets")
        expect(page).to have_current_path("/pets")
      end
    end

    it "I see a favorite indicator in my navigation bar" do
      @pages.each do |path|
        visit path
        within(".nav") do
          expect(page).to have_content("Favorite Pets: 0")
        end
      end
    end

    it "and I can click on the favoite indicator,
    I am taken to the favorites index page" do
      @pages.each do |path|
        visit path
        within(".nav") do
          click_link "Favorite Pets: 0"
          expect(page).to have_current_path("/favorites")
        end
      end
    end
  end
end


# User Story 11, Favorite Indicator links to Index Page
#
# As a visitor
# When I click on the favorite indicator in the nav bar
# I am taken to the favorites index page
