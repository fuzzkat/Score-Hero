class NoteView
  
  def initialize note
    @note = note
  end
  
  def render screen, x, middle_c_y, white_note_height
     y = middle_c_y - get_relative_y_pos(white_note_height)
 
     yradius = white_note_height
     xradius = yradius*1.35
     draw_width = xradius*0.08
     color = [0,0,0]
     screen.draw_ellipse(x, y, xradius, yradius, color, true, true)
     if(@note < 71)
       screen.draw_rect(x+xradius, y, -draw_width, yradius*-7, color, true)
     else
       screen.draw_rect(x-xradius, y, draw_width, yradius*7, color, true)
     end
     
     overhang = xradius/3
     ledger_lines(middle_c_y, white_note_height).each do |line_y|
       screen.draw_rect(x-xradius-overhang, middle_c_y - line_y, xradius*2+overhang*2, draw_width, color, true)
     end
   end
   
   
end