require File.expand_path(File.dirname(__FILE__) + '/test_helper')

require 'random_tune_model'

class TC_KeypressModel < Test::Unit::TestCase
 
  def test_contains_100_notes
    unit = RandomTuneModel.new
    
    assert_equal(100, unit.length())
      
    unit.each do |note|
      assert_equal Note, note.class
    end
  end
  
  def test_contains_only_notes_between_middle_c_and_high_c
    middle_c = 60
    high_c = 82
    
    unit = RandomTuneModel.new
    
    unit.each do |note|
      assert note.midi_pitch >= middle_c
      assert note.midi_pitch <= high_c
    end
  end
end