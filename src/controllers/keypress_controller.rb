require 'controller'
require 'app_logger'

class KeypressController < Controller
 
  def initialize midi_input
    @midi_input = midi_input
    @@log = AppLogger.get_logger()
  end

  def open
    super
    midi_events = @midi_input.read(16)
    if !midi_events.nil?
      midi_events.each{|event|
        @@log.debug{"Processing midi event: #{event}"}
        note = event[:message][1].to_i
        if event[:message][2] > 0
          @model << note
          @@log.info{"note #{note} on"}
        else
          @model.delete note
          @@log.info{"note #{note} off"}
        end
        @@log.debug{"keypress model: #{@model.object_id}"}
      }
    end
  end
end