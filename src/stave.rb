class Stave

  def initialize middle_c_pos, note_height
    @note_height = note_height
    @middle_c_pos = middle_c_pos
  end
  
  def render screen, width
    (0..4).each do |line|
      line_y = @middle_c_pos - (line+1)*@note_height*2
      screen.draw_line 0,line_y,width,line_y,0  
      end
  end
  
end