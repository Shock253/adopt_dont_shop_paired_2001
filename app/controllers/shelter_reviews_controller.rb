class ShelterReviewsController < ApplicationController
  def edit
    @shelter =  Shelter.find(params[:id])
    @review = ShelterReview.find(params[:review_id])
    # => TODO: maybe fix this? we can get the review through the shelter
  end

  def new
    @shelter = Shelter.find(params[:id])
  end

  def create
    shelter = Shelter.find(params[:id])
    review = shelter.shelter_reviews.create(shelter_review_params)
    if review.save
        redirect_to "/shelters/#{shelter.id}"
    else
      flash[:notice] = "Could not create shelter: Please make sure to enter title, rating, and content"
      redirect_to "/shelters/#{shelter.id}/reviews/new"
    end
  end

  def update

    shelter = Shelter.find(params[:id])
    review = ShelterReview.find(params[:review_id])
    review.update(shelter_review_params)
    if review.save
      redirect_to "/shelters/#{shelter.id}"
    else
      flash[:notice] = "Update not recorded: Please enter title, rating, and content to edit review."
      redirect_to "/shelters/#{shelter.id}/reviews/#{review.id}/edit"
    end
  end

  private

  def shelter_review_params
    params.permit(:title, :rating, :content, :image)
  end
end
