require 'rails_helper'

RSpec.describe FavoritePets, type: :model do
  describe "#total_count" do
    it "can find total number of favorite pets" do
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

      favorite_pets = FavoritePets.new([
          pet_1.id,
          pet_2.id
        ])
      expect(favorite_pets.total_count).to eq(2)
    end
  end
end
