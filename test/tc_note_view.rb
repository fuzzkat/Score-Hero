$: << File.expand_path(File.dirname(__FILE__) + "/../src")
$: << File.expand_path(File.dirname(__FILE__))

require 'test/unit'
require 'note_view'
require 'note'
require 'controller'
require 'mock_screen'

class TC_NoteView < Test::Unit::TestCase

  BLACK = [0,0,0]

  def setup
    @controller = Controller.new
    @c4 = NoteView.new(Note.new(60), Controller.new)
    @a3 = NoteView.new(Note.new(57), Controller.new)
    @fsharp4 = NoteView.new(Note.new(66), Controller.new)
  end

  def test_get_relative_y_pos
    assert_equal(0, @c4.get_relative_y_pos(10))
    assert_equal(-10, @a3.get_relative_y_pos(5))
    assert_equal(6, @fsharp4.get_relative_y_pos(2))
  end

  def test_off_stave_bottom
    assert_equal([-20,0], NoteView.new(Note.new(55), @controller).ledger_lines(240,10)) #G3
    assert_equal([-20,0], NoteView.new(Note.new(57), @controller).ledger_lines(240,10)) #A3
    assert_equal([0], NoteView.new(Note.new(59), @controller).ledger_lines(240,10)) #B3
    assert_equal([0], NoteView.new(Note.new(60), @controller).ledger_lines(240,10)) #C4
    assert_equal([], NoteView.new(Note.new(62), @controller).ledger_lines(240,10)) #D4
    assert_equal([], NoteView.new(Note.new(64), @controller).ledger_lines(240,10)) #E4
    assert_equal([], NoteView.new(Note.new(66), @controller).ledger_lines(240,10)) #F4
  end

  def test_off_stave_top
    assert_equal([], NoteView.new(Note.new(77), @controller).ledger_lines(240,10)) #F4
    assert_equal([], NoteView.new(Note.new(79), @controller).ledger_lines(240,10)) #G4
    assert_equal([120], NoteView.new(Note.new(81), @controller).ledger_lines(240,10)) #A4
    assert_equal([120], NoteView.new(Note.new(83), @controller).ledger_lines(240,10)) #B4
    assert_equal([120,140], NoteView.new(Note.new(84), @controller).ledger_lines(240,10)) #C5
    assert_equal([120,140], NoteView.new(Note.new(86), @controller).ledger_lines(240,10)) #D5
    assert_equal([120,140,160], NoteView.new(Note.new(88), @controller).ledger_lines(240,10)) #E5
    assert_equal([120,140,160], NoteView.new(Note.new(89), @controller).ledger_lines(240,10)) #F5
  end

  def test_render_ascending_crotchet
    unit = NoteView.new(Note.new(60), @controller)
    middle_c_y = 100
    white_note_height = 20
    x = 40
    screen = MockScreen.new

    unit.render(screen,x,middle_c_y,white_note_height)
    assert_equal(1,screen.ellipses.size)
    assert_equal([40,100,27.0,20,BLACK,true,true,nil], screen.ellipses[0])
    assert_equal(2,screen.rects.size)
    assert_equal([67.0,100,-2.16,-140,BLACK,true,nil],screen.rects[0])
    assert_equal([4.0,100,72.0,2.16,BLACK,true,nil],screen.rects[1])
  end

  def test_render_decending_crotchet
    unit = NoteView.new(Note.new(72), @controller)
    middle_c_y = 100
    white_note_height = 20
    x = 40
    screen = MockScreen.new

    unit.render(screen,x,middle_c_y,white_note_height)
    assert_equal(1,screen.ellipses.size)
    assert_equal([40,-40,27.0,20,BLACK,true,true,nil], screen.ellipses[0])
    assert_equal(1,screen.rects.size)
    assert_equal([13.0,-40,2.16,140,BLACK,true,nil],screen.rects[0])
  end

end