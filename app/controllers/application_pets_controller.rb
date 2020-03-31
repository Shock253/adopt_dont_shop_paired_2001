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

  def approve
    pet = Pet.find(params[:pet_id])
    pet.status = "Pending"
    application_pet = pet.find_application_pet(params[:application_id])
    application_pet.status = "Approved"
    application_pet.save
    pet.save
    redirect_to "/pets/#{params[:pet_id]}"
  end

  def approve_pets
    pets = Pet.find(params[:pet_ids])
    pets.each do |pet|
      pet.status = "Pending"
      application_pet = pet.find_application_pet(params[:application_id])
      application_pet.status = "Approved"
      application_pet.save
      pet.save
    end
    redirect_to '/pets'
  end

  private

  def application_params
    params.permit(:name, :address, :city, :state, :zip, :phone_number, :description, :pet_ids)
  end
end
