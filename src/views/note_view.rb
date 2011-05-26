require 'note'
require 'view'

class NoteView < View

  COLOUR = [0,0,0]
  MIDDLE_LINE_OF_STAVE = 71

  def initialize model, controller, stave_view
    super model, controller
    @stave_view = stave_view
  end

  def render screen, x
    @screen = screen
    @x = x

    draw_note()
    draw_ledger_lines()
  end

  private
  
  def draw_note()
    @y = @stave_view.middle_c_pos - @stave_view.get_relative_y_pos_of(@model.midi_pitch)

    @yradius = @stave_view.white_note_height
    @xradius = @yradius*1.35

    @screen.draw_ellipse(@x, @y, @xradius, @yradius, COLOUR, true, true)

    draw_stem()
  end

  def draw_stem()
    @draw_width = @xradius*0.08
        
    if(@model.midi_pitch < MIDDLE_LINE_OF_STAVE)
      draw_descending_stem()
    else
      draw_ascending_stem()
    end
  end

  def draw_ascending_stem
    @screen.draw_rect(@x-@xradius, @y, @draw_width, @yradius*7, COLOUR, true)
  end

  def draw_descending_stem
    @screen.draw_rect(@x+@xradius, @y, -@draw_width, @yradius*-7, COLOUR, true)
  end

  def draw_ledger_lines
    @stave_view.ledger_lines(@model).each do |ledger_y|
      y = @stave_view.middle_c_pos - ledger_y
      draw_ledger_line(@x, y)
    end
  end

  def draw_ledger_line x, y
    ledger_overhang = @xradius/3
    ledger_start_x = x-@xradius-ledger_overhang
    ledger_width = @xradius*2 + ledger_overhang*2
        
    @screen.draw_rect(ledger_start_x, y, ledger_width, @draw_width, COLOUR, true)
  end

end