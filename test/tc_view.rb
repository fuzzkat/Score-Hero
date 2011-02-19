require File.expand_path(File.dirname(__FILE__) + '/test_helper')

require 'view'
require 'controller'

class TC_View < Test::Unit::TestCase
  
  def test_sub_view_default_render
    model = "model"
    controller = Controller.new
    
    sub_view_1 = MockView.new model, controller
    sub_view_2 = MockView.new model, controller
    
    unit = View.new model, controller
    
    unit.add_sub_view(sub_view_1)
    unit.add_sub_view(sub_view_2)
    
    screen = "My Fake Screen"
    
    unit.render screen
    
    assert_equal screen, sub_view_1.rendered_to, "Sub view 1 not rendered"
    assert_equal screen, sub_view_2.rendered_to, "Sub view 2 not rendered"
  end
  
  def test_super_view
    model = "model"
    controller = Controller.new
    
    unit = View.new model, controller
    sub_view = View.new model, controller
    
    unit.add_sub_view(sub_view)
    
    assert_equal unit, sub_view.super_view, "Sub view does not know its parent"
  end

  def test_set_draw_area
    unit = MockView.new "model", Controller.new
    unit.set_draw_area(50,55,100,80)
    assert_equal(50, unit.x)
    assert_equal(55, unit.y)
    assert_equal(100, unit.w)
    assert_equal(80, unit.h)
  end
  
  class MockView < View
    attr_accessor :rendered_to, :x, :y, :w, :h
    
    def render screen
      @rendered_to = screen
    end
  end
  
end