$: << File.expand_path(File.dirname(__FILE__) + "/../src")
$: << File.expand_path(File.dirname(__FILE__))

require 'test/unit'
require 'stave_view'
require 'controller'
require 'mock_screen'

class TC_StaveView < Test::Unit::TestCase
  def test_render
    screen = MockScreen.new
    
    unit = StaveView.new nil, Controller.new

    unit.set_draw_area(0,0,600,150)

    unit.render screen

    assert_equal([0,65,600,65,0], screen.lines[0])
    assert_equal([0,55,600,55,0], screen.lines[1])
    assert_equal([0,45,600,45,0], screen.lines[2])
    assert_equal([0,35,600,35,0], screen.lines[3])
    assert_equal([0,25,600,25,0], screen.lines[4])
  end

end