require File.expand_path(File.dirname(__FILE__) + '/test_helper')

require 'keypress_model'

class TC_KeypressModel < Test::Unit::TestCase
 
  def setup
   @keys = []
  end
  
  def test_keypress_observer
    unit = KeypressModel.new
    unit.registerObserver(self)
    
    unit.press(32)
    assert_equal(32,@last_key_pressed,"Observer should have been notified with key 32")
    
    unit.press(29)
    assert_equal(29,@last_key_pressed,"Observer should have been notified with key 29")
  end

  def test_keys_pressed_update_chord
    unit = KeypressModel.new
    
    unit.press(12)
    unit.press(16)
    unit.press(32)
    unit.release(16)
    
    assert_equal([12, 32], unit.chord())
  end
    
  def notify(key)
    @last_key_pressed = key
  end
end