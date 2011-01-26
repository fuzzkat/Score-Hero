$: << File.expand_path(File.dirname(__FILE__) + "/../src")

require 'test/unit'
require 'note_view'
require 'note'

class TC_NoteView < Test::Unit::TestCase
 
  def setup
    @c4 = NoteView.new(Note.new(60))
    @a3 = NoteView.new(Note.new(57))
    @fsharp4 = NoteView.new(Note.new(66))
  end
  
  def test_get_relative_y_pos
    assert_equal(0, @c4.get_relative_y_pos(10))
    assert_equal(-10, @a3.get_relative_y_pos(5))
    assert_equal(6, @fsharp4.get_relative_y_pos(2))
  end
  
  def test_off_stave_bottom
    assert_equal([-20,0], NoteView.new(Note.new(55)).ledger_lines(240,10)) #G3
    assert_equal([-20,0], NoteView.new(Note.new(57)).ledger_lines(240,10)) #A3
    assert_equal([0], NoteView.new(Note.new(59)).ledger_lines(240,10)) #B3
    assert_equal([0], NoteView.new(Note.new(60)).ledger_lines(240,10)) #C4
    assert_equal([], NoteView.new(Note.new(62)).ledger_lines(240,10)) #D4
    assert_equal([], NoteView.new(Note.new(64)).ledger_lines(240,10)) #E4
    assert_equal([], NoteView.new(Note.new(66)).ledger_lines(240,10)) #F4
  end
  
  def test_off_stave_top
    assert_equal([], NoteView.new(Note.new(77)).ledger_lines(240,10)) #F4
    assert_equal([], NoteView.new(Note.new(79)).ledger_lines(240,10)) #G4
    assert_equal([120], NoteView.new(Note.new(81)).ledger_lines(240,10)) #A4
    assert_equal([120], NoteView.new(Note.new(83)).ledger_lines(240,10)) #B4
    assert_equal([120,140], NoteView.new(Note.new(84)).ledger_lines(240,10)) #C5
    assert_equal([120,140], NoteView.new(Note.new(86)).ledger_lines(240,10)) #D5
    assert_equal([120,140,160], NoteView.new(Note.new(88)).ledger_lines(240,10)) #E5
    assert_equal([120,140,160], NoteView.new(Note.new(89)).ledger_lines(240,10)) #F5
  end
  
end