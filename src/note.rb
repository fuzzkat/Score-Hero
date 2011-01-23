class Note
  NOTES = [
    {:name => "C", :white_key_index => 0},
    {:name => "C#", :white_key_index => 0},
    {:name => "D", :white_key_index => 1},
    {:name => "D#", :white_key_index => 1},
    {:name => "E", :white_key_index => 2},
    {:name => "F", :white_key_index => 3},
    {:name => "F#", :white_key_index => 3},
    {:name => "G", :white_key_index => 4},
    {:name => "G#", :white_key_index => 4},
    {:name => "A", :white_key_index => 5},
    {:name => "A#", :white_key_index => 5},
    {:name => "B", :white_key_index => 6}
  ]
  
  def initialize note
    @note = note.to_i
    #puts @note
  end
  
  def render screen, x, middle_c_y, line_height
    y = middle_c_y - get_relative_y_pos(middle_c_y, line_height)

    yradius = line_height
    xradius = yradius*1.35
    draw_width = xradius*0.08
    color = [0,0,0]
    screen.draw_ellipse(x, y, xradius, yradius, color, true, true)
    if(@note < 66)
      screen.draw_rect(x+xradius, y, draw_width, yradius*-7, color, true)
    else
      screen.draw_rect(x-xradius, y, draw_width, yradius*7, color, true)
    end
    
    if(ledger_line?) 
      screen.draw_rect(x-xradius-4, y, xradius*2+8, draw_width, color, true)
    end
  end
  
  def render_keypress screen, x, middle_c_y, line_height
    y = middle_c_y - get_relative_y_pos(middle_c_y, line_height)

    yradius = line_height
    xradius = yradius*1.35
    color = [0,200,0]
    screen.draw_ellipse(x, y, xradius, yradius, color, true, true)
  end
  
  def name
    NOTES[@note%12][:name] + octave().to_s
  end
  
  def octave
    ((@note/12).to_i)-1
  end
  
  private
  
  def whitekey_index
    NOTES[@note%12][:white_key_index]
  end
  
  def get_relative_y_pos middle_c_y, line_height
    ((octave()-4)*7 + whitekey_index()) * line_height
  end
  
  def ledger_line?
    if(@note < 62 || @note > 80)
      (octave.modulo(2) == 0 && whitekey_index.modulo(2) == 0) ||
      (octave.modulo(2) == 1 && whitekey_index.modulo(2) == 1)
    else
      false
    end
  end
end