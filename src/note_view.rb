require 'note'
require 'view'

class NoteView < View

  def initialize model, controller, stave_view
    super model, controller
    @stave_view = stave_view
  end
  
  def render screen, x
    middle_c_y = @stave_view.middle_c_pos
    white_note_height = @stave_view.white_note_height
    y = middle_c_y - @stave_view.get_relative_y_pos_of(@model.midi_pitch)

    yradius = white_note_height
    xradius = yradius*1.35
    draw_width = xradius*0.08
    color = [0,0,0]
    screen.draw_ellipse(x, y, xradius, yradius, color, true, true)
    if(@model.midi_pitch < 71)
      screen.draw_rect(x+xradius, y, -draw_width, yradius*-7, color, true)
    else
      screen.draw_rect(x-xradius, y, draw_width, yradius*7, color, true)
    end

    overhang = xradius/3

    @stave_view.ledger_lines(@model).each do |line_y|
      screen.draw_rect(x-xradius-overhang, middle_c_y - line_y, xradius*2+overhang*2, draw_width, color, true)
    end
  end

end