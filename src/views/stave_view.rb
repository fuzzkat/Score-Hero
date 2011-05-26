require 'view'
require 'note'

class StaveView < View
  attr_accessor :middle_c_pos, :white_note_height
  
  def render screen
    (0..4).each do |line|
      line_y = middle_c_pos - (line+1) * white_note_height * 2
      screen.draw_line @x,line_y,@w,line_y,0
    end
    
    screen.draw_rect(@w/2-10,@middle_c_pos,20,@white_note_height*-12,[255,0,0])

    super
  end

  def set_draw_area x,y,w,h
    super(x,y,w,h)
    set_sub_view_draw_area()
    @middle_c_pos = @h/2 + @y
    @white_note_height =  @h / 30
  end

  def get_relative_y_pos_of note
    ((Note.octave_of(note)-4)*7 + Note.whitekey_index_of(note)) * white_note_height
  end
  
  def ledger_lines note
    note_range = 0..0
    if(note.midi_pitch < 62)
      note_range = note.midi_pitch..62
    elsif(note.midi_pitch > 80)
      note_range = 80..note.midi_pitch
    end
    
    lines = []
    note_range.each do |note_pitch|
      lines << get_relative_y_pos_of(note_pitch) if should_draw_ledger_line_for(note_pitch)
    end
    lines.uniq()
  end
  
  def should_draw_ledger_line_for(note_pitch)
    (Note.octave_of(note_pitch).modulo(2) == 0 && Note.whitekey_index_of(note_pitch).modulo(2) == 0) ||
    (Note.octave_of(note_pitch).modulo(2) == 1 && Note.whitekey_index_of(note_pitch).modulo(2) == 1)
  end
  
end