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
    assert_equal(0, @c4.get_relative_y_pos(0,10))
    assert_equal(-10, @a3.get_relative_y_pos(0,5))
    assert_equal(6, @fsharp4.get_relative_y_pos(0,2))
  end
  
  def test_off_stave_bottom
    assert(!ExposedNote.new(55).ledger_line?()) #G3
    assert( ExposedNote.new(57).ledger_line?()) #A3
    assert(!ExposedNote.new(59).ledger_line?()) #B3
    assert( ExposedNote.new(60).ledger_line?()) #C4
    assert(!ExposedNote.new(62).ledger_line?()) #D4
    assert(!ExposedNote.new(64).ledger_line?()) #E4
    assert(!ExposedNote.new(66).ledger_line?()) #F4
  end
  
  def test_off_stave_top
    assert(!ExposedNote.new(77).ledger_line?()) #F4
    assert(!ExposedNote.new(79).ledger_line?()) #G4
    assert( ExposedNote.new(81).ledger_line?()) #A4
    assert(!ExposedNote.new(83).ledger_line?()) #B4
    assert( ExposedNote.new(84).ledger_line?()) #C4
    assert(!ExposedNote.new(86).ledger_line?()) #D4
    assert( ExposedNote.new(88).ledger_line?()) #E4
  end
  
  class ExposedNote < Note
    def get_relative_y_pos middle_c_y, line_height
      super middle_c_y, line_height
    end
    
    def ledger_line?
      super
    end
    
    def whitekey_index
      super
    end
  end
  
end