class Shelter < ApplicationRecord
  has_many :pets, dependent: :destroy
  has_many :shelter_reviews
  validates_presence_of :name, :address, :city, :state, :zip

  def pet_count
    self.pets.count
  end

  def self.sort_alphabetical
    Shelter.order("name")
  end
end
