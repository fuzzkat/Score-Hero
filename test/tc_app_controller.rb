require File.expand_path(File.dirname(__FILE__) + '/test_helper')

require 'app_controller'

class TC_MVC < Test::Unit::TestCase
  
  def test_mvc_construction_adds_all_subviews
    unit = AppController.new
    view = View.new(nil, unit)
    unit.construct_mvc_map(1)
    
    assert_equal 1, view.sub_views.length
    stave_view = view.sub_views.first
    assert_equal StaveView, stave_view.class
    
    stave_sub_views = stave_view.sub_views
    
    sub_view_classes = stave_sub_views.collect{ |sub_view| sub_view.class }
    
    assert sub_view_classes.include?(TuneView), "TuneView not found"
    assert sub_view_classes.include?(KeypressView), "KeypressView not found"

    assert_equal 2, stave_sub_views.length
  end
  
end