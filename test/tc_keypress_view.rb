$: << File.expand_path(File.dirname(__FILE__) + "/../src")

require 'test/unit'
require 'keypress_view'

class TC_KeypressView < Test::Unit::TestCase
 
  def test_render
    screen = MockScreen.new
    
    KeypressView.render(60,screen,0,100,5)
    
    elipse = screen.ellipses()[0]
    
    assert_equal([0,100,6.75,5,[0,100,0],true,true], elipse)
  end
  
  class MockScreen
    
    def initialize
      @ellipses = []
    end
    
    def draw_ellipse x, y, xradius, yradius, color, fill, aa
      @ellipses << [x, y, xradius, yradius, color, fill, aa]
    end
    
    def ellipses
      @ellipses
    end
   
  end
  
end