class FavoritesController < ApplicationController

  def add
    pet = Pet.find(params[:pet_id])
    session[:favorites] ||= []
    session[:favorites] << pet.id
    flash[:notice] = "Pet successfully added to Favorites!"
    redirect_to "/pets/#{pet.id}"
  end
end
