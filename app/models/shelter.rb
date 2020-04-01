class Shelter < ApplicationRecord
  has_many :pets, dependent: :destroy
  has_many :shelter_reviews, dependent: :destroy
  validates_presence_of :name, :address, :city, :state, :zip

  def pet_count
    self.pets.count
  end

  def has_pending_adoptions?
    pending = self.pets.any? do |pet|
      pet.application_pets.any? do |application_pet|
        application_pet.status == "Approved"
      end
    end
    pending
  end

  def average_rating
    shelter_reviews.average(:rating)
  end

  def current_applications

  end

  def self.sort_alphabetical
    Shelter.order("name")
  end
end
