require File.expand_path(File.dirname(__FILE__) + '/test_helper')

require 'keypress_controller'

class TC_KeypressController < Test::Unit::TestCase
  def test_open
    model = []
    midi_input = MockMidiInput.new
    unit = KeypressController.new(midi_input)
    unit.model = model
    
    unit.open()
    assert_equal([60,64,67], model)
    
    unit.open()
    assert_equal([67, 72], model)
    
    unit.open()
    assert_equal([67], model)
    
    unit.open()
    assert_equal([], model)
  end
  
  class MockMidiInput
    def initialize
      @events = [
        {:timestamp=>5100, :message=>[144, 67, 0, 0]},
        {:timestamp=>5100, :message=>[144, 71, 0, 0]},
        {:timestamp=>4590, :message=>[144, 71, 34, 0]},
        {:timestamp=>4540, :message=>[144, 67, 26, 0]},
        {:timestamp=>3860, :message=>[144, 67, 0, 0]},
        {:timestamp=>3850, :message=>[144, 72, 0, 0]},
        {:timestamp=>3840, :message=>[144, 60, 0, 0]},
        {:timestamp=>3840, :message=>[144, 64, 0, 0]},
        {:timestamp=>3340, :message=>[144, 72, 52, 0]},
        {:timestamp=>3010, :message=>[144, 67, 26, 0]},
        {:timestamp=>2750, :message=>[144, 64, 32, 0]},
        {:timestamp=>2350, :message=>[144, 60, 33, 0]}
      ]
    end
        
    def read(event_count)
      (@events.pop 3).reverse
    end
  end

end