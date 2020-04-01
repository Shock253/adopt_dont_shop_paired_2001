class AddRatingToShelterReviews < ActiveRecord::Migration[5.1]
  def change
    add_column :shelter_reviews, :rating, :integer
  end
end
