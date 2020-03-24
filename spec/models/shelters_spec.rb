require 'rails_helper'

RSpec.describe Shelter, type: :model do
  describe "validations" do
    it { should validate_presence_of :name}
    it { should validate_presence_of :address}
    it { should validate_presence_of :city}
    it { should validate_presence_of :state}
    it { should validate_presence_of :zip}
  end

  describe "relationships", type: :model do
    it { should have_many :pets}
  end

  describe "instance methods", type: :model do
    it '.pet_count' do
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
      expect(shelter_1.pet_count).to eq(1)
    end

    describe "class methods", type: :model do
      it ".sort_alphabetical" do
        shelter_1 = Shelter.create(name: "Denver Animal Shelter",
                             address: "500 Invisible St.",
                             city: "Denver",
                             state: "Colorado",
                             zip: "80201")

        shelter_2 = Shelter.create(name: "Downtown Animal Shelter",
                             address: "2550 WeWatta St.",
                             city: "Denver",
                             state: "Colorado",
                             zip: "80222")

        shelter_3 = Shelter.create(name: "Aurora Animal Shelter",
                             address: "3665 E. Colfax Ave.",
                             city: "Aurora",
                             state: "Colorado",
                             zip: "80399")

        expect(Shelter.sort_alphabetical).to eq([shelter_3, shelter_1, shelter_2])
      end
    end
  end
end
