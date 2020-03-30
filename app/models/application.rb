class Application < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip, :phone_number, :description
  has_many :application_pets, dependent: :destroy
  has_many :pets, through: :application_pets
end
