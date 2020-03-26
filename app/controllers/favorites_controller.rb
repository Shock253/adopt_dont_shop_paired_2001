class FavoritesController < ApplicationController

  def update
    favorite_pets.add_pet(params[:pet_id])
    session[:favorites] = favorite_pets.contents
    flash[:notice] = "Pet successfully added to Favorites!"
    redirect_to "/pets/#{params[:pet_id]}"
  end

  def index
    @pets = Pet.find(favorite_pets.contents)
  end
end
