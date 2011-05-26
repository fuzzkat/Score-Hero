require 'view'

class AppView < View
  
  PAPER_COLOUR = [255,255,255]
  BORDER_COLOUR = [120,0,0]
  
  def initialize model, controller
    super(model, controller)
  end
    
  def set_draw_area(x,y,w,h)
    super(x,y,w,h)
    @border_size = @h/20
    @white_note_height = @h/24
    @middle_c_pos = @h/2+@white_note_height*6
    
    set_draw_area_of_sub_views
  end
  
  def set_draw_area_of_sub_views
    sub_views().each do |sub_view|
      sub_view.set_draw_area(0, @border_size, @w, @h)
    end
  end
  
  def render screen
    render_background screen
    super
    screen.flip
  end

  def render_background screen
    screen.draw_rect 0, 0, @w, @border_size, BORDER_COLOUR, true
    screen.draw_rect 0, @h-@border_size, @w, @border_size, BORDER_COLOUR, true
    screen.draw_rect 0, @border_size, @w, @h-@border_size*2, PAPER_COLOUR, true
  end

end