class Pet < ApplicationRecord
  after_initialize :set_defaults, unless: :persisted?
  belongs_to :shelter
  validates_presence_of :image, :name, :age, :sex, :description, :status

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
end
