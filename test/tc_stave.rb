$: << File.expand_path(File.dirname(__FILE__) + "/../src")

require 'test/unit'
require 'stave'

class TC_Stave < Test::Unit::TestCase
 
  def test_render
    unit = Stave.new(100,10)
    
    screen = MockScreen.new
    unit.render(screen,600)
    
    assert_equal([0,80,600,80,0], screen.lines[0])
    assert_equal([0,60,600,60,0], screen.lines[1])
    assert_equal([0,40,600,40,0], screen.lines[2])
    assert_equal([0,20,600,20,0], screen.lines[3])
    assert_equal([0,0,600,0,0], screen.lines[4])
  end
  
  class MockScreen
    
    def initialize
      @lines = []
    end
    
    def draw_line x1,y1,x2,y2,colour
      @lines << [x1,y1,x2,y2,colour]
    end
    
    def lines
      @lines
    end
   
  end
  
end