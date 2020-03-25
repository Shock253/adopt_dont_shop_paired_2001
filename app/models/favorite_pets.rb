class FavoritePets
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || []
  end

  def total_count
    @contents.length
  end
end
