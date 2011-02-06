$: << File.expand_path(File.dirname(__FILE__) + "/../src")
$: << File.expand_path(File.dirname(__FILE__))

require 'test/unit'
require 'tune_view'
require 'controller'
require 'mock_screen'

class TC_TuneView < Test::Unit::TestCase
  
  def test_something
    note_view = MockNoteView.new
    screen = MockScreen.new
    
    unit = TuneView.new([60,62,64,68], Controller.new)
    
    unit.render screen
  end
  
  class MockNoteView
    def render screen
    end
  end
    
end