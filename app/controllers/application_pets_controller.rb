class ApplicationPetsController < ApplicationController
  def new
    @pets = Pet.find(session[:favorites])
  end

  def create
    application = Application.create(application_params)
    if application.save
      params[:pet_ids].each do |id|
        application.application_pets.create(pet_id: id)
      end
      params[:pet_ids].each { |pet_id| favorite_pets.remove_pet(pet_id) }
      session[:favorites] = favorite_pets.contents
      redirect_to "/favorites"
      flash[:notice] = "Application successfully submitted!"
    else
      flash[:notice] = "Required fields are missing! Please make sure to include all of the information listed in the application."
      redirect_to "/applications/new"
    end
  end

  def show
    @application = Application.find(params[:id])
  end

  private

  def application_params
    params.permit(:name, :address, :city, :state, :zip, :phone_number, :description, :pet_ids)
  end
end
