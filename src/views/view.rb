require 'app_logger'

class View
  attr_accessor :super_view, :sub_views, :model, :controller
  def initialize model, controller
    @@log = AppLogger.get_logger()
    @model = model
    @controller = controller
    @controller.view = self
    @controller.model = model
    @sub_views = []
  end

  def add_sub_view view
    @sub_views << view
    view.super_view = self
  end

  def render screen
    @sub_views.each{|sub_view| sub_view.render(screen) }
  end

  def set_draw_area x,y,w,h
    @@log.info {self.class().name() + "Draw area set to pos:#{x},#{y}; size:#{w},#{h}."}
    @x,@y,@w,@h = x,y,w,h
  end
  
  def set_sub_view_draw_area
    @sub_views.each{|sub_view| sub_view.set_draw_area(@x,@y,@w,@h)}
  end
end