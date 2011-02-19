require File.expand_path(File.dirname(__FILE__) + '/test_helper')

require 'note_view'
require 'stave_view'
require 'note'
require 'controller'
require 'mock_screen'

class TC_NoteView < Test::Unit::TestCase

  BLACK = [0,0,0]

  def setup
    @controller = Controller.new
    @stave_view = StaveView.new(nil,@controller)
    @stave_view.white_note_height = 20
    @stave_view.middle_c_pos = 100
  end

  def test_render_ascending_crotchet
    unit = NoteView.new(Note.new(60), @controller, @stave_view)
    x = 40
    screen = MockScreen.new

    unit.render(screen,x)
    assert_equal(1,screen.ellipses.size)
    assert_equal([40,100,27.0,20,BLACK,true,true,nil], screen.ellipses[0])
    assert_equal(2,screen.rects.size)
    assert_equal([67.0,100,-2.16,-140,BLACK,true,nil],screen.rects[0])
    assert_equal([4.0,100,72.0,2.16,BLACK,true,nil],screen.rects[1])
  end

  def test_render_decending_crotchet
    unit = NoteView.new(Note.new(72), @controller, @stave_view)
    x = 40
    screen = MockScreen.new

    unit.render(screen,x)
    assert_equal(1,screen.ellipses.size)
    assert_equal([40,-40,27.0,20,BLACK,true,true,nil], screen.ellipses[0])
    assert_equal(1,screen.rects.size)
    assert_equal([13.0,-40,2.16,140,BLACK,true,nil],screen.rects[0])
  end

end