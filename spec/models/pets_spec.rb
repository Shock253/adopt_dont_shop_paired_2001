require 'rails_helper'

RSpec.describe Pet, type: :model do
  describe "validations" do
    it { should validate_presence_of :image}
    it { should validate_presence_of :name}
    it { should validate_presence_of :age}
    it { should validate_presence_of :sex}
    it { should validate_presence_of :description}
    it { should validate_presence_of :status}
  end

  describe "relationships" do
    it { should belong_to :shelter }
  end

  describe "class methods", type: :model do
    it "sort by adoptable pets" do
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
                      status: "Adoptable")
      expect(Pet.sort_adoptable).to eq([pet_2, pet_1])
    end

    it "find adoptable pets" do
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
                      name: 'Rover',
                      age: 3,
                      sex: "Male",
                      shelter: shelter_1,
                      description: "He's a biter.",
                      status: "Adoptable")
      expect(Pet.find_adoptable).to eq([pet_2])
    end

    it "find pending adoption pets" do
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
                      name: 'Rover',
                      age: 3,
                      sex: "Male",
                      shelter: shelter_1,
                      description: "He's a biter.",
                      status: "Adoptable")

      expect(Pet.find_pending).to eq([pet_1])
    end
  end
end
