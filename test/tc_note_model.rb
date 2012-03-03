require File.expand_path(File.dirname(__FILE__) + '/test_helper')

require 'note_model'

class TC_NoteModel < Test::Unit::TestCase
 
  def setup
    @c4 = NoteModel.new(60)
    @a3 = NoteModel.new(57)
    @fsharp4 = NoteModel.new(66)
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
  
  def test_midi_pitch
    assert_equal(60, @c4.midi_pitch())
    assert_equal(57, @a3.midi_pitch())
    assert_equal(66, @fsharp4.midi_pitch())
  end
  
end