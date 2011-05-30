require 'view'
require 'note_view'
require 'note'

class TuneView < View
  attr_writer :note_view
  
  CROTCHET_WIDTH = 40
  
  def initialize model, controller
    super
    @note_view = NoteView    
  end
  
  
  def add_notes_as_sub_views
    @model.each do | note |
      note_sub_view = @note_view.new(note, Controller.new)
      add_sub_view(note_sub_view)
    end
  end

  def render screen
    view_centre = @w/2
    @sub_views.each_with_index do |sub_view, index|
      note_pos = index-@controller.pos 
      sub_view.render(screen, view_centre + note_pos*CROTCHET_WIDTH)
    end
  end
  
end