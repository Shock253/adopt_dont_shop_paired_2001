class ShelterPetsController < ApplicationController

  def index
    @shelter = Shelter.find(params[:id])
    if params["adoptable"] == "true"
      @pets = @shelter.pets.find_adoptable
    elsif params["adoptable"] == "false"
      @pets = @shelter.pets.find_pending
    else
      @pets = @shelter.pets.sort_adoptable
    end
  end
end
