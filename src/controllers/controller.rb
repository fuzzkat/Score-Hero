class Controller
  attr_accessor :view, :model
  
  def open
    view.sub_views.each{ |sub_view| sub_view.controller.open } if view 
  end
  
end