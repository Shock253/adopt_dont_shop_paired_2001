class SheltersController < ApplicationController

  def index
    if params["alpha"] == "true"
      @shelters = Shelter.sort_alphabetical
    else
      @shelters = Shelter.all
    end
  end

  def show
    @shelter = Shelter.find(params[:id])
  end

  def new
  end

  def create
    shelter = Shelter.create(shelter_params)
    shelter.save
    redirect_to '/shelters'
  end

  def edit
    @shelter = Shelter.find(params[:id])
  end

  def update
    shelter = Shelter.find(params[:id])
    shelter.update(shelter_params)
    shelter.save
    redirect_to "/shelters/#{shelter.id}"
  end

  def destroy
    shelter = Shelter.find(params[:id])
    if !shelter.has_pending_adoptions?
      Shelter.destroy(params[:id])
      redirect_to '/shelters'
    else
      flash[:notice] = "Could not delete shelter, shelter has pending adoptions"
      redirect_to "/shelters/#{params[:id]}"
    end
  end

  private

  def shelter_params
    params.permit(:name, :address, :city, :state, :zip)
  end
end
