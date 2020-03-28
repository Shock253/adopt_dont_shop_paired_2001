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

  def favorited?(pet_id)
    @contents.include?(pet_id)
  end
end
