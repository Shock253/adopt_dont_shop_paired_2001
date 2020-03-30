class FavoritePets
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || []
  end

  def add_pet(pet)
    @contents << pet
  end

  def remove_pet(pet)
    @contents.delete(pet.to_s)
  end

  def total_count
    @contents.length
  end

  def favorited?(pet_id)
    @contents.include?(pet_id.to_s)
  end

  def remove_pet(pet)
    @contents.delete(pet)
  end

  def remove_all_pets
    @contents = []
  end

  def remove_pet(pet)
    @contents.delete(pet)
  end

  def remove_all_pets
    @contents = []
  end
end
