$: << File.expand_path(File.dirname(__FILE__) + "/../src")
$: << File.expand_path(File.dirname(__FILE__))

require 'test/unit'
require 'app_view'
require 'app_controller'
require 'mock_screen'

class TC_AppView < Test::Unit::TestCase
  WHITE = [255,255,255]
  DARK_RED = [120,0,0]
  PRESSED_KEYS = [60,65,72]
  RED = [255,0,0]
  
  def test_render
    screen = MockScreen.new
    sub_view = MockView.new nil, Controller.new 
        
    unit = AppView.new(nil, AppController.new)

    unit.add_sub_view(sub_view)
    
    unit.set_draw_area(0, 0, 640, 480)
    
    unit.render(screen)
    assert_equal([0,0,640,24,DARK_RED,true,nil], screen.rects[0])
    assert_equal([0,456,640,24,DARK_RED,true,nil], screen.rects[1])
    assert_equal([0,24,640,432,WHITE,true,nil], screen.rects[2])
    
    cursor_rect = screen.rects[3]
    assert_equal([310,400,20,-320,RED,false,nil], cursor_rect)
    
    assert(sub_view.rendered?)
    
    assert(screen.flipped?)
    
  end
  
  class MockView < View
    def initialize model, controller
      super
      @rendered = false
    end

    def render screen
      @rendered = true
    end

    def rendered?
      @rendered
    end
  end
  
end