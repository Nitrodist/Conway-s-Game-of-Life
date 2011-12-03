require "test/unit"

X_WIDTH = 150
Y_WIDTH = 150

class World
  @state = "." * X_WIDTH * Y_WIDTH
  def self.to_s
    return @state 
  end
  def self.add (x,y)
    @state[y*X_WIDTH+x] = '#'
  end
  def self.del (x,y)
    @state[y*X_WIDTH+x] = '.'
  end
  def self.num_neighbors (x, y)
    count = 0
    count +=1 if present?(x-1,y-1)
    count +=1 if present?(x-1,y)
    count +=1 if present?(x-1,y+1)
    count +=1 if present?(x,y-1)
    count +=1 if present?(x,y+1)
    count +=1 if present?(x+1,y-1)
    count +=1 if present?(x+1,y)
    count +=1 if present?(x+1,y+1)
    count
  end
  def self.present? (x,y)
    @state[y*X_WIDTH+x] == '#'
  end

  def self.will_be_alive? (x,y)
    alive = present?(x,y)
    if alive
      return true if num_neighbors(x, y) >= 2 && num_neighbors(x, y) <= 3
    else
      #fkin daead people
      return true if num_neighbors(x, y) == 3
    end
    false
  end

  def self.iterate
    newState = "." * 50
    (0..9).each do |x|
      (0..4).each do |y|
        if will_be_alive?(x,y)
          newState[y*10+x] = '#'
        end
      end
    end
    @state = newState
  end

  def set_state(newState)
    @state = newState
  end

end

class WorldTest < Test::Unit::TestCase
  
  def setup
  end
  
  def test_world_has_string_output_and_matches_output
    
    World.add(5, 2)

    World.present?(5, 2)

    assert World.will_be_alive?(5, 2) == false

    World.del(5,2)

    assert World.present?(5, 2) == false

    World.add(5, 2)
    World.add(5, 3)

    assert World.num_neighbors(5, 2) == 1
    assert World.num_neighbors(5, 3) == 1

    World.add(4, 3)

    expected2 = ".........." +  # 0
                ".........." +  # 1
                ".....#...." +  # 2
                "....##...." +  # 3 
                ".........."    # 4
                #0123456789
    
    assert World.num_neighbors(5, 3) == 2
    
    assert World.will_be_alive?(4, 2) == true
    # 3 neighbors living. <-- this goes above 

    expected2 = ".........." +  # 0
                ".........." +  # 1
                ".....#...." +  # 2
                "...###...." +  # 3 
                ".........."    # 4
                #0123456789
    World.add(3,3)
    assert World.present?(4, 2) == false
    assert World.will_be_alive?(4, 2) == false


    expected2 = ".........." +  # 0
                ".........." +  # 1
                "....##...." +  # 2
                "...###...." +  # 3 
                ".........."    # 4
                #0123456789
    World.add(4, 2)
    assert World.present?(4, 2) == true
    assert World.will_be_alive?(4, 2) == false
  
    World.iterate()

    assert World.present?(4, 2) == false

 end
  
  
  def teardown
  end
  
end 

#    expected2 = ".#........" +  # 0
#                "..#......." +  # 1
#                "###......." +  # 2
#                ".........." +  # 3 
#                ".........."    # 4
#                #0123456789
#World.set_state(expected2)


