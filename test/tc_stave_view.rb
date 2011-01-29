$: << File.expand_path(File.dirname(__FILE__) + "/../src")
$: << File.expand_path(File.dirname(__FILE__))

require 'test/unit'
require 'stave_view'
require 'mock_screen'

class TC_StaveView < Test::Unit::TestCase
  def test_render
    unit = StaveView.new(100,10)

    screen = MockScreen.new
    unit.render(screen,600)

    assert_equal([0,80,600,80,0], screen.lines[0])
    assert_equal([0,60,600,60,0], screen.lines[1])
    assert_equal([0,40,600,40,0], screen.lines[2])
    assert_equal([0,20,600,20,0], screen.lines[3])
    assert_equal([0,0,600,0,0], screen.lines[4])
  end

end