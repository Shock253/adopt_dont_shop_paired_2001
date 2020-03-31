class Pet < ApplicationRecord
  after_initialize :set_defaults, unless: :persisted?
  belongs_to :shelter
  validates_presence_of :image, :name, :age, :sex, :description, :status
  has_many :application_pets, dependent: :destroy
  has_many :applications, through: :application_pets

  def set_defaults
    self.status ||= 'Adoptable'
  end

  def self.sort_adoptable
    Pet.order("status")
  end

  def self.find_adoptable
    where(status: "Adoptable")
  end

  def self.find_pending
    where(status: "Pending Adoption")
  end

  def find_application_pet(app_id)
    application_pets.where(application_id: app_id).first
  end

  def find_approved_application
    if application_pets.where(status: 'Approved').first
      application_pets.where(status: 'Approved').first.application
    else
      nil
    end
  end

  def application_approved?
    if find_approved_application.nil?
      false
    else
      true
    end
  end
end
