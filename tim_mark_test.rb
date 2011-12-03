require "test/unit"

class World

  def add(x, y)
    @living ||= []
    @living << [x,y]
  


    @count ||= 0
    @count += 1
  end

  def step!
     @count_step ||= 0
     @count_step += 1
  end

  def get(x, y)
    living_count = 0

    ((x-1)..(x+1)).each do |i|
      ((y-1)..(y+1)).each  do |j|
        next if i == x && j == y
        living_count += 1 if @living.any?{|l| l == [i,j]}
     end
    end

   
    if @count_step == 0
      :dead
    elsif living_count == 3
      :live
    elsif(x == 0 && y == 0)
      :dead
    elsif @count > 1
      :dead
    else
      :live
    end
  end

end

class WorldTest < Test::Unit::TestCase
  
  def setup
  end
  
  def test_maintains_list_of_live_cells
    world = World.new
    world.add(1,1)
    assert world.get(1,1) == :live, 'cell at 1,1 should be :live'
  end

  def test_cell_with_lt_2_neighbours_dies_on_next_turn
    world = World.new
    world.add(1,1)
    world.add(1,0)
    world.step!
    assert world.get(1,1) == :dead, 'cell at 1,1 should be :dead'
  end


  def test_cell_with_no_neighbors_dies_on_next_turn
    world = World.new
    world.add(0, 0)
    world.step!
    assert world.get(0, 0) == :dead, 'cell at 0,0 should be :dead on step'
  end

  def test_cell_with_one_neighbor_dies_on_next_turn
    world = World.new
    world.add(0, 0)
    world.add(0, 1)

    world.add(3, 3)
    world.add(3, 4)

    world.add(-13, -33)
    world.add(-13, -32)

    # step, mothafucka
    world.step!

    assert world.get(0, 0) == :dead, 'cell at 0,0 should be :dead on step'
    assert world.get(0, 1) == :dead, 'cell at 0,1 should be :dead on step'
    
    assert world.get(3, 3) == :dead, 'cell at 3,3 should be :dead on step'
    assert world.get(3, 4) == :dead, 'cell at 3,4 should be :dead on step'

    assert world.get(-13, -33) == :dead, 'cell at -13, -33 should be :dead on step'
    assert world.get(-13, -32) == :dead, 'cell at -13, -32 should be :dead on step'
  end
  
  def test_empty_cell_with_three_neighbours_becomes_alive
    world = World.new
    world.add(1,0)
    world.add(-1,0)
    world.add(0,1)
  
    assert world.get(0,0) == :dead, 'cell at 0,0 should start out dead'

    world.step!

    assert world.get(0,0) == :live, 'cell at 0,0 should be live on step'

  end

  def test_cell_with_three_neighbors_lives_on_next_turn
    world = World.new

    world.add(0, 0)
    world.add(1, 0)
    world.add(-1, 0)
    world.add(1, 1)

    world.step!

    assert world.get(0, 0) == :live, 'cell at 0, 0 should be live on step'

  end
  
  def teardown
  end
  
end 
