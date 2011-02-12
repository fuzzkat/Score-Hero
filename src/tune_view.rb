require 'view'
require 'note_view'
require 'note'

class TuneView < View
  attr_writer :note_view
  
  def initialize model, controller
    super
    @note_view = NoteView    
  end
  
  
  def add_sub_view
    @model.each do | note |
      super(@note_view.new(note, Controller.new, super_view))
    end
  end

  def render screen
    @sub_views.each_with_index do |sub_view, index| 
      sub_view.render(screen, @w/2 + (index-@controller.pos)*40)
    end
  end
  
end