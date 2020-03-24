class PetsController < ApplicationController
  def index
    if params["adoptable"] == "true"
      @pets = Pet.find_adoptable
    elsif params["adoptable"] == "false"
      @pets = Pet.find_pending
    else
      @pets = Pet.all.sort_adoptable
    end
  end

  def show
    @pet = Pet.find(params[:id])
  end

  def new
    @shelter = Shelter.find(params[:id])
  end

  def create
    shelter = Shelter.find(params[:id])
    pet = shelter.pets.create(pet_params)
    pet.save
    redirect_to "/shelters/#{shelter.id}/pets"
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    pet = Pet.find(params[:id])
    pet.update(pet_params)
    pet.save
    redirect_to "/pets/#{pet.id}"
  end

  def destroy
    Pet.destroy(params[:id])
    redirect_to '/pets'
  end

  def pending
    pet = Pet.find(params[:id])
    pet.status = "Pending Adoption"
    pet.save
    redirect_to "/pets/#{pet.id}"
  end

  def adoptable
    pet = Pet.find(params[:id])
    pet.status = "Adoptable"
    pet.save
    redirect_to "/pets/#{pet.id}"
  end

  private

  def pet_params
    params.permit(:name, :age, :sex, :image, :description)
  end
end
