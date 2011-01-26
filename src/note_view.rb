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
    if(@note.midi < 71)
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

  def get_relative_y_pos white_note_height
    get_relative_y_pos_of(@note.midi,white_note_height)
  end

  def get_relative_y_pos_of note, white_note_height
    ((Note.octave_of(note)-4)*7 + Note.whitekey_index_of(note)) * white_note_height
  end

  def ledger_lines middle_c_y, white_note_height
    lines = []
    if(@note.midi < 62)
      (@note.midi..62).each do |note|
        if((Note.octave_of(note).modulo(2) == 0 && Note.whitekey_index_of(note).modulo(2) == 0) ||
        (Note.octave_of(note).modulo(2) == 1 && Note.whitekey_index_of(note).modulo(2) == 1))
          lines << get_relative_y_pos_of(note, white_note_height)
        end
      end
    end

    if(@note.midi > 80)
      (80..@note.midi).each do |note|
        if((Note.octave_of(note).modulo(2) == 0 && Note.whitekey_index_of(note).modulo(2) == 0) ||
        (Note.octave_of(note).modulo(2) == 1 && Note.whitekey_index_of(note).modulo(2) == 1))
          lines << get_relative_y_pos_of(note, white_note_height)
        end
      end
    end
    lines.uniq()
  end
end