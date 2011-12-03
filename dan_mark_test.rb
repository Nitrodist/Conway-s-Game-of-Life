require "test/unit"

X = 0
Y = 1

class Universe

  attr_accessor :grid

  def cells_around_cell(x, y)
    [
    [x + -1, y + -1], 
    [x + -1, y + 0], 
    [x + -1, y + 1], 
    [x + 0,  y + -1], 
    [x + 0,  y + 1], 
    [x + 1,  y + -1], 
    [x + 1,  y + 0], 
    [x + 1,  y + 1], 
    ]
  end

  def initialize( alive_cells )
    @grid = {}
    alive_cells.each do |cell|
      @grid["#{cell[X]},#{cell[Y]}"] = true
    end
  end

  def alive?( x, y )
    return @grid.key? "#{x},#{y}"
  end

  def evolve
    new_grid = {}
    @grid.keys.each do |key|
      count = number_of_neighbors(key.split(',')[0], key.split(',')[1])
      if count >= 2 && count <= 3
        new_grid["#{cell[X]},#{cell[Y]}"] = true
      end
    end

    @grid = new_grid
  end

  def cells_to_test
    cells_to_test_hash = {}
    @grid.keys.each do |key|
      x = key.split(',')[0]
      y = key.split(',')[1]
      cells_around_cell = cells_around_cell(x, y)
      cells.each do |cell|
        cells_to_test_hash["#{cell[X]},#{cell[Y]}"]
      end
    end
    cells_to_test = []
    cells_to_test_hash.keys.each do |cell_coords|
      
      cells_to_test << []
    end
    cells_to_test
  end

  def number_of_alive_neighbors(x, y)
#    valid_cells = [
#                  [x + -1, y + -1], 
#                  [x + -1, y + 0], 
#                  [x + -1, y + 1], 
#                  [x + 0,  y + -1], 
#                  [x + 0,  y + 1], 
#                  [x + 1,  y + -1], 
#                  [x + 1,  y + 0], 
#                  [x + 1,  y + 1], 
#                  ]
#    num_alive_neighbours = 0 
#    valid_cells.each do |valid_cell|
#      num_alive_neighbours += 1 if alive?(valid_cell[0], valid_cell[1])
#    end
#    return num_alive_neighbours
  end
end

class UniverseTest < Test::Unit::TestCase
  
  def setup
    alive_cells = [
                  [0, 0], 
                  [0, 1], 
                  [1, 0], 
                  [1, 1]
                  ]
    @universe = Universe.new(alive_cells)

  end
  
  def test_state_can_be_set_initially
    assert(@universe.alive?(0, 0) == true, "Cell should be alive at 0, 0")
    assert(@universe.alive?(0, 1) == true, "Cell should be alive at 0, 1")
    assert(@universe.alive?(1, 0) == true, "Cell should be alive at 1, 0")
    assert(@universe.alive?(-1, 0) == false, "Cell should be dead at -1, 0")
  end

  def test_universe_can_evolve
#    @universe.evolve
#    @universe.grid.count == 4
#    assert(@universe.alive?(0, 0) == true, "Cell should be alive at 0, 0")
#    assert(@universe.alive?(0, 1) == true, "Cell should be alive at 0, 1")
#    assert(@universe.alive?(1, 0) == true, "Cell should be alive at 1, 0")
#    assert(@universe.alive?(-1, 0) == false, "Cell should be dead at -1, 0")
  end


  def test_a_cell_with_three_neighbors_has_three_neighbors
#    assert(@universe.number_of_neighbors(0, 0) == 3, 'Cell at 0, 0 should have 3 neighbors.')
  end

  def test_determine_which_cells_to_test
    cells_to_test = [
                    [0, 0], 
                    [0, 1], 
                    [1, 0], 
                    [1, 1],
                    [2, -1], 
                    [2, 0], 
                    [2, 1], 
                    [2, 2],
                    [1, -1], 
                    [1, 2], 
                    [0, -1], 
                    [0, 2],
                    [-1, -1], 
                    [-1, 0], 
                    [-1, 1], 
                    [-1, 2]
                    ]
    assert(@universe.cells_to_test == cells_to_test, 'Blah')
  end

  def test_cells_around_cell
    cells_around_zero_zero = [[1, -1],
                              [1, 0],
                              [1, 1],
                              [0, -1],
                              [0, 1],
                              [-1, -1],
                              [-1, 0],
                              [-1, 1]]

    assert( arrays_equal(@universe.cells_around_cell(0, 0), cells_around_zero_zero ), "Cells around 0, 0 should be the same as we expect.")
  end

  def arrays_equal(array_one, array_two)
    array_one.each_with_index do |array_one_coord, i| 
      false if array_one_coord[0] == array_two[i][0]
      false if array_one_coord[1] == array_two[i][1]
    end
    return true
  end
  
  def teardown
  end
  
end 
