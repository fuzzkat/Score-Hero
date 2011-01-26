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
  
  def render_keypress screen, x, middle_c_y, white_note_height
    y = middle_c_y - get_relative_y_pos(white_note_height)

    yradius = white_note_height
    xradius = yradius*1.35
    color = [0,200,0]
    screen.draw_ellipse(x, y, xradius, yradius, color, true, true)
  end
  
  def name
    name_of @note
  end
  
  def name_of note
    NOTES[note%12][:name] + octave_of(note).to_s
  end

  def octave
    octave_of @note
  end
  
  def octave_of note
    (note/12-1).to_i
  end
  
  private
  
  def whitekey_index
    whitekey_index_of @note
  end
  
  def whitekey_index_of note
    NOTES[note%12][:white_key_index]
  end
  
  def get_relative_y_pos white_note_height
    get_relative_y_pos_of(@note,white_note_height)
  end
  
  def get_relative_y_pos_of note, white_note_height
    ((octave_of(note)-4)*7 + whitekey_index_of(note)) * white_note_height
  end
  
  def ledger_lines middle_c_y, white_note_height
    lines = []
    if(@note < 62) 
      (@note..62).each do |note|
        if((octave_of(note).modulo(2) == 0 && whitekey_index_of(note).modulo(2) == 0) ||
           (octave_of(note).modulo(2) == 1 && whitekey_index_of(note).modulo(2) == 1))
          lines << get_relative_y_pos_of(note, white_note_height)
        end
      end
    end
    
    if(@note > 80) 
      (80..@note).each do |note|
        if((octave_of(note).modulo(2) == 0 && whitekey_index_of(note).modulo(2) == 0) ||
           (octave_of(note).modulo(2) == 1 && whitekey_index_of(note).modulo(2) == 1))
          lines << get_relative_y_pos_of(note, white_note_height)
        end
      end
    end
    lines.uniq()
  end
end