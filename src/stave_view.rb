require 'view'

class StaveView < View
  attr_accessor :middle_c_pos, :white_note_height
  def render screen
    (0..4).each do |line|
      line_y = middle_c_pos - (line+1) * white_note_height * 2
      screen.draw_line @x,line_y,@w,line_y,0
    end
    super
  end

  def set_draw_area x,y,w,h
    super(x,y,w,h)
    set_sub_view_draw_area
    @middle_c_pos = @h/2 + @y
    @white_note_height =  @h / 30
  end

end