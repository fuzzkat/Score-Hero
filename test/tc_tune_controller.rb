require File.expand_path(File.dirname(__FILE__) + '/test_helper')

require 'tune_controller'
require 'view'

class TC_TuneController < Test::Unit::TestCase
  def test_open_calls_super
    unit = TuneController.new(120)
    
    sub_controller = SubController.new
    
    unit.view = View.new(nil,Controller.new)
    unit.view.add_sub_view(View.new(nil,sub_controller))
    
    unit.open()
    assert(sub_controller.opened)
  end
  
  def test_open_sets_pos_at_120bpm
    unit = TuneControllerWrapped.new(120)
    unit.view = View.new(nil,Controller.new)
    
    unit.time = 1000
    unit.open()
    
    assert_equal(2000, unit.pos)
  end
  
  def test_open_sets_pos_at_60bpm
    unit = TuneControllerWrapped.new(60)
    unit.view = View.new(nil,Controller.new)
    
    unit.time = 1000
    unit.open()
    
    assert_equal(1000, unit.pos)
  end
  
  class TuneControllerWrapped < TuneController
    attr_accessor :time
    
    def initialize tempo
      @time = 0
      super
    end
    
    def get_time
      @time
    end
  end
  
  class SubController < Controller
    attr_accessor :opened
    def open
      @opened = true
    end
  end
  
end