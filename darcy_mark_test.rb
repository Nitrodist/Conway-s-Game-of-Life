require "test/unit"

class World

  def self.countblah
    @count ||= 1
    @count += 1
  end

  def self.neighbors(x, y)
    x_range = (x-1)..(x+1)
    y_range = (y-1)..(y+1)
    count = 0
    x_range.each do |current_x| 
      y_range.each do |current_y|
        if x == current_x && y == current_y

        else
          if @cells[current_x.to_s + ',' + current_y.to_s] 
            count += 1
          end
        end
      end
    end

    return count
  end

  def self.add(x, y)
    @cells ||= Hash.new
    @cells[x.to_s + ',' + y.to_s] = true
  end

  def self.alive?(x, y)
    ! @cells[x.to_s + ',' + y.to_s].nil?
  end

  def self.next_alive?(x, y)

    count = neighbors(x, y)

    if count < 2
      return false
    end    

    return true

  end

  def self.step
    next_cells = Hash.new

    # "1,0"
    @cells.keys.each do |cell_coords| 
      x = cell_coords.split(',')[0].to_i
      y = cell_coords.split(',')[1].to_i
      next_cells[x.to_s + ',' + y.to_s] = true if next_alive?(x, y)
    end
    @cells = next_cells
  end

end

class WorldTest < Test::Unit::TestCase
  
  def setup
  end
  
  def test_live_cell
    World.add(0, 0) 
    assert(World.alive?(0, 0) == true, 'should be alive at 0, 0')
  end

  def test_live_cell_with_fewer_than_two_neighbors_dies
    World.add(0, 0)
    World.add(0, 1)
    World.step
    assert(World.alive?(0, 0) == false, 'cell 1 should be dead at 0, 0 after a step')
    assert(World.alive?(0, 1) == false, 'cell 2 should be dead at 0, 1 after a step')
  end

  def test_live_cell_with_one_neighbor_should_have_one_neighbor
    World.add(0, 0)
    World.add(0, 1)

    assert(World.neighbors(0, 0) == 1, "cell should have 1 neighbor -- got #{World.neighbors(0, 0)}")
    assert(World.neighbors(0, 1) == 1, "cell should have 1 neighbor -- got #{World.neighbors(0, 1)}")
  end

  def test_live_cell_with_two_or_three_neightbors_lives
    World.add(0, 0)
    World.add(0, 1)
    World.add(1, 1)

    World.step

    assert(World.alive?(0, 0) == true, 'should be alive at 0, 0')
    assert(World.alive?(0, 1) == true, 'should be alive at 0, 1')
    assert(World.alive?(1, 1) == true, 'should be alive at 1, 1')
  end


  def test_live_cell_with_4_neighbors_dies
    puts World.countblah
    World.add(0, 0)
    World.add(1, 0)
    World.add(0, 1)
    World.add(-1, 0)
    World.add(0, -1)

    World.step

    assert(World.alive?(0, 0) == false, 'should be dead at 0, 0')

  end

  
  def teardown
  end
  
end 
