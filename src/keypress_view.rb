require 'note_view'
require 'app_logger'

class KeypressView < View

  def initialize model, controller
    super
    @@log = AppLogger.get_logger()
  end
  
  def render screen
    @@log.debug("rendering keypresses: #{@model.object_id}")
    @model.each do |note|
      y = super_view.middle_c_pos - NoteView.get_relative_y_pos_of(note, super_view.white_note_height)
  
      yradius = super_view.white_note_height
      xradius = yradius*1.35
      color = [0,100,0]
      screen.draw_ellipse(@w/2, y, xradius, yradius, color, true, true)
    end
  end

end