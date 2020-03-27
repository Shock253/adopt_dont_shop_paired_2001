class FavoritePets
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || []
  end

  def add_pet(pet)
    @contents << pet
  end

  def total_count
    @contents.length
  end

  def remove_pet(pet)
    @contents.delete(pet)
  end
end
