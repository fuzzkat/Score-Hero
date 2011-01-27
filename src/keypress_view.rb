require 'note_view'

class KeypressView

  def KeypressView.render note, screen, x, middle_c_y, white_note_height
    y = middle_c_y - NoteView.get_relative_y_pos_of(note, white_note_height)

    yradius = white_note_height
    xradius = yradius*1.35
    color = [0,100,0]
    screen.draw_ellipse(x, y, xradius, yradius, color, true, true)
  end

end