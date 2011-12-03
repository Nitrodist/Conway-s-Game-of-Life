require "test/unit"

class World
end

class WorldTest < Test::Unit::TestCase
  
  def setup
  end
  
  def test_some_test_name
    @some_value = Hellsdafksdklfalo.new
    puts @some_value
    @some_value.x = 1
    assert(@some_value.x == 1)
  end
  
  
  def teardown
  end
  
end 
