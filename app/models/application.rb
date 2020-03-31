class Application < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip, :phone_number, :description
  has_many :application_pets, dependent: :destroy
  has_many :pets, through: :application_pets

  def pending_approval?(pet_id_param)
    application_pets.where(pet_id: pet_id_param).first.status == "Pending Approval"
  end
end
