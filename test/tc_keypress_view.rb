require File.expand_path(File.dirname(__FILE__) + '/test_helper')

require 'keypress_view'
require 'keypress_controller'
require 'mock_screen'

class TC_KeypressView < Test::Unit::TestCase
  def test_render
    screen = MockScreen.new
    model = [60,64]
    unit = KeypressView.new(model,KeypressController.new(3))
    super_view = MockSuperView.new
    super_view.middle_c_pos = 100
    super_view.white_note_height = 5
    super_view.screen_width = 600
    unit.super_view = super_view
    
    unit.set_draw_area(0,0,600,400)
    
    unit.render screen
    
    assert_equal 2, screen.ellipses().size()

    assert_equal([300,40,6.75,5,[0,100,0],true,true,nil], screen.ellipses()[0])
    assert_equal([300,36,6.75,5,[0,100,0],true,true,nil], screen.ellipses()[1])
  end

  class MockSuperView
    attr_accessor :middle_c_pos, :white_note_height, :screen_width
    
    def get_relative_y_pos_of(note)
      return note
    end
  end
end