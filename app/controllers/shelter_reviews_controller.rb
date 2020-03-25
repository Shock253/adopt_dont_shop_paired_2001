class ShelterReviewsController < ApplicationController
  def edit
    @shelter =  Shelter.find(params[:id])
    @review = ShelterReview.find(params[:review_id])
  end

  def update
    shelter = Shelter.find(params[:id])
    review = ShelterReview.find(params[:review_id])
    review.update(shelter_review_params)
    redirect_to "/shelters/#{shelter.id}"
  end

  private

  def shelter_review_params
    params.permit(:title, :rating, :content, :image)
  end
end
