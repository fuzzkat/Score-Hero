$: << File.expand_path(File.dirname(__FILE__) + "/../src")

require 'test/unit'
require 'note'

class TC_Note < Test::Unit::TestCase
 
  def setup
    @c4 = ExposedNote.new(60)
    @a3 = ExposedNote.new(57)
    @fsharp4 = ExposedNote.new(66)
  end
  
  def test_name
    assert_equal("A3", @a3.name())
    assert_equal("C4", @c4.name())
    assert_equal("F#4",@fsharp4.name())
  end
  
  def test_octave
    assert_equal(3, @a3.octave())  
    assert_equal(4, @c4.octave())
    assert_equal(4, @fsharp4.octave())
  end
  
  def test_whitekey_index
    assert_equal(5, @a3.whitekey_index())
    assert_equal(0, @c4.whitekey_index())
    assert_equal(3, @fsharp4.whitekey_index())
  end
  
  def test_get_relative_y_pos
    assert_equal(0, @c4.get_relative_y_pos(10))
    assert_equal(-10, @a3.get_relative_y_pos(5))
    assert_equal(6, @fsharp4.get_relative_y_pos(2))
  end
  
  def test_off_stave_bottom
    assert_equal([-20,0], ExposedNote.new(55).ledger_lines(240,10)) #G3
    assert_equal([-20,0], ExposedNote.new(57).ledger_lines(240,10)) #A3
    assert_equal([0], ExposedNote.new(59).ledger_lines(240,10)) #B3
    assert_equal([0], ExposedNote.new(60).ledger_lines(240,10)) #C4
    assert_equal([], ExposedNote.new(62).ledger_lines(240,10)) #D4
    assert_equal([], ExposedNote.new(64).ledger_lines(240,10)) #E4
    assert_equal([], ExposedNote.new(66).ledger_lines(240,10)) #F4
  end
  
  def test_off_stave_top
    assert_equal([], ExposedNote.new(77).ledger_lines(240,10)) #F4
    assert_equal([], ExposedNote.new(79).ledger_lines(240,10)) #G4
    assert_equal([120], ExposedNote.new(81).ledger_lines(240,10)) #A4
    assert_equal([120], ExposedNote.new(83).ledger_lines(240,10)) #B4
    assert_equal([120,140], ExposedNote.new(84).ledger_lines(240,10)) #C5
    assert_equal([120,140], ExposedNote.new(86).ledger_lines(240,10)) #D5
    assert_equal([120,140,160], ExposedNote.new(88).ledger_lines(240,10)) #E5
    assert_equal([120,140,160], ExposedNote.new(89).ledger_lines(240,10)) #F5
  end
  
  class ExposedNote < Note
    def get_relative_y_pos white_note_height
      super white_note_height
    end
    
    def ledger_lines middle_c_y, white_note_height
      super middle_c_y, white_note_height
    end
    
    def whitekey_index
      super
    end
  end
  
end