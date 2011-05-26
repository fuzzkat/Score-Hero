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
  
  
  def add_sub_view
    @model.each do | note |
      note_sub_view = @note_view.new(note, Controller.new, super_view)
      super(note_sub_view)
    end
  end

  def render screen
    @sub_views.each_with_index do |sub_view, index| 
      sub_view.render(screen, @w/2 + (index-@controller.pos) * CROTCHET_WIDTH)
    end
  end
  
end