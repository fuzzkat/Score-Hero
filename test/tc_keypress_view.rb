$: << File.expand_path(File.dirname(__FILE__) + "/../src")
$: << File.expand_path(File.dirname(__FILE__))
require 'test/unit'
require 'keypress_view'
require 'mock_screen'

class TC_KeypressView < Test::Unit::TestCase
  def test_render
    screen = MockScreen.new

    KeypressView.render(60,screen,0,100,5)

    elipse = screen.ellipses()[0]

    assert_equal([0,100,6.75,5,[0,100,0],true,true,nil], elipse)
  end

end