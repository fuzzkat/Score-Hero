$: << File.expand_path(File.dirname(__FILE__) + "/../src")
$: << File.expand_path(File.dirname(__FILE__))

require 'test/unit'
require 'view'
require 'controller'

class TC_MVC < Test::Unit::TestCase
  
  def test_open_passes_control_to_children_through_view_heirarchy
    report = []
    
    top_level_controller = ReportingController.new(report)
    top_level_view = View.new(:top_level, top_level_controller)
    
    subview_1 = View.new(:subview_1, ReportingController.new(report))
    top_level_view.add_sub_view(subview_1)
    
    second_level_subview = View.new(:subsubview_1, ReportingController.new(report))
    subview_1.add_sub_view(second_level_subview)
        
    subview_2 = View.new(:subview_2, ReportingController.new(report))
    top_level_view.add_sub_view(subview_2)
    
    top_level_controller.open
    
    assert_equal [:top_level, :subview_1, :subsubview_1, :subview_2], report
  end
  
  class ReportingController < Controller
    attr_accessor :report
    def initialize report
      @report = report 
    end
    
    def open
      @report << view.model
      super
    end
  end
  
end