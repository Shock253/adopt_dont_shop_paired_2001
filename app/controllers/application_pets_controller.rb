class ApplicationPetsController < ApplicationController
  def new
    @pets = Pet.find(session[:favorites])
  end

  def create
    application = Application.create(application_params)
    params[:pet_ids].each { |pet_id| favorite_pets.remove_pet(pet_id) }
    session[:favorites] = favorite_pets.contents
    redirect_to "/favorites"
    flash[:notice] = "Application successfully submitted!"
  end

  private

  def application_params
    params.permit(:name, :address, :city, :state, :zip, :phone_number, :description, :pet_ids)
  end
end
