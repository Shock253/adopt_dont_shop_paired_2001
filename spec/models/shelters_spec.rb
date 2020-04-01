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
    it { should have_many :pets }
    it { should have_many :shelter_reviews }
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

    it ".average_rating" do
      shelter_1 = Shelter.create!(name: "Denver Animal Shelter",
                                 address: "500 Invisible St.",
                                 city: "Denver",
                                 state: "Colorado",
                                 zip: "80201")

      review1 = shelter_1.shelter_reviews.create!(title: "Horrible Shelter",
                                     rating: "1/5",
                                     content: "They stole my dog!",
                                     image: "https://i.ytimg.com/vi/tLY-qCnnPQM/maxresdefault.jpg")

      review2 = shelter_1.shelter_reviews.create!(title: "Great Experience!",
                                     rating: "3/5",
                                     content: "Grabbed a new dog and ran away with it!",
                                     image: "https://i.ytimg.com/vi/tLY-qCnnPQM/maxresdefault.jpg")

      review3 = shelter_1.shelter_reviews.create!(title: "Horrible Shelter",
                                     rating: "1/5",
                                     content: "They stole my dog!")

      expect(shelter_1.average_rating.to_f).to eq(5.0/3.0)
    end

    it ".count_current_applications" do
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

      application = Application.create(
                     name: "John Wick",
                     address: "450 S. Cherry St.",
                     city: "Aldoran",
                     state: "CO",
                     zip: "19999",
                     phone_number: "8007891234",
                     description: "I have a big yard")

      ApplicationPet.create(application: application, pet: pet_1, status: "Approved")

      expect(shelter_1.count_current_applications).to eq(1)
    end

    it ".has_pending_adoptions?" do
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

      application = Application.create(
                     name: "John Wick",
                     address: "450 S. Cherry St.",
                     city: "Aldoran",
                     state: "CO",
                     zip: "19999",
                     phone_number: "8007891234",
                     description: "I have a big yard")

      ApplicationPet.create(application: application, pet: pet_1, status: "Approved")

      expect(shelter_1.has_pending_adoptions?).to eq(true)
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
