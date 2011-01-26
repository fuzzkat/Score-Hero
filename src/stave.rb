class Stave
  
  def initialize
  end
  
  def render screen, middle_c_pos, note_height
    (0..4).each do |line|
      line_y = middle_c_pos - (line+1)*note_height*2
      screen.draw_line 0,line_y,SCREEN_WIDTH,line_y,0  
      end
    
    screen.draw_rect(SCREEN_WIDTH/2-10,MIDDLE_C_POS+note_height*2,20,note_height*-16,[255,0,0])
  end
  
end