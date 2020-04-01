class RemoveRatingFromShelterReviews < ActiveRecord::Migration[5.1]
  def change
    remove_column :shelter_reviews, :rating, :string
  end
end
