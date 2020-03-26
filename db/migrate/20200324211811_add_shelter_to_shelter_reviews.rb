class AddShelterToShelterReviews < ActiveRecord::Migration[5.1]
  def change
    add_reference :shelter_reviews, :shelter, foreign_key: true
  end
end
