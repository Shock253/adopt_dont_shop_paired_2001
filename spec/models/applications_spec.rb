require 'rails_helper'

RSpec.describe Application, type: :model do
  describe "validations" do
    it { should validate_presence_of :name}
    it { should validate_presence_of :address}
    it { should validate_presence_of :city}
    it { should validate_presence_of :state}
    it { should validate_presence_of :zip}
    it { should validate_presence_of :phone_number}
    it { should validate_presence_of :description}
  end

  describe "relationships" do
    it { should have_many :application_pets }
    it { should have_many(:pets).through(:application_pets) }
  end

  describe "#pending_approval?" do
    it "can tell if it is pending approval" do
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
                      status: "adoptable")

      pet_2 = Pet.create(image: 'app/assets/images/border_collie.jpg',
                      name: 'Rover',
                      age: 3,
                      sex: "Male",
                      shelter: shelter_1,
                      description: "He's a biter.",
                      status: "adoptable")
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

      expect(application.pending_approval?(pet_1.id)).to eq(true)
    end
  end
end
