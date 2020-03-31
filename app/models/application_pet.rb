class ApplicationPet < ApplicationRecord
  after_initialize :set_defaults, unless: :persisted?
  belongs_to :application
  belongs_to :pet
  validates_presence_of :status

  def set_defaults
    self.status ||= 'Pending Approval'
  end
end
