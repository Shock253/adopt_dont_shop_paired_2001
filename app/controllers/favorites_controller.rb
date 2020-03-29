class FavoritesController < ApplicationController

  def update
    favorite_pets.add_pet(params[:pet_id])
    session[:favorites] = favorite_pets.contents
    flash[:notice] = "Pet successfully added to Favorites!"
    redirect_to "/pets/#{params[:pet_id]}"
  end

  def destroy
    favorite_pets.remove_pet(params[:pet_id])
    session[:favorites] = favorite_pets.contents
    flash[:notice] = "Pet successfully removed from Favorites!"
    redirect_to "/pets/#{params[:pet_id]}"
  end

  def index
    @pets = Pet.find(favorite_pets.contents)
    pet_ids = ApplicationPet.pluck(:pet_id)
    @pending_pets = Pet.find(pet_ids)
  end

  def delete
    favorite_pets.remove_pet(params[:pet_id])
    session[:favorites] = favorite_pets.contents
    redirect_to "/favorites"
  end

  def delete_all
    favorite_pets.remove_all_pets
    session[:favorites] = favorite_pets.contents
    redirect_to "/favorites"
  end
end
