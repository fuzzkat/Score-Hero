require 'controller'
require 'app_logger'

class KeypressController < Controller

  MIDI_BATCH_SIZE = 16
  NOTE_PRESS_MIN_VELOCITY = 1
  
  def initialize midi_input
    @midi_input = midi_input
    @@log = AppLogger.get_logger()
  end

  def open
    super
    processMidiEvents()
  end

  private
  
  def processMidiEvents
    midi_events = readBatchOfMidiEvents()

    midi_events.each do |event|
      processMidiEvent(event)
    end
  end

  def readBatchOfMidiEvents
    @midi_input.read(MIDI_BATCH_SIZE) || []
  end

  def processMidiEvent(event)
    @@log.debug{"Processing midi event: #{event}"}

    @event_note = event[:message][1].to_i
    @event_velocity = event[:message][2]

    processKeyToggle
  end

  def processKeyToggle
    if note_pressed?
      addToCurrentChord @event_note
    else
      removeFromCurrentChord @event_note
    end
  end

  def note_pressed?
    @event_velocity >= NOTE_PRESS_MIN_VELOCITY
  end

  def addToCurrentChord note
    @model << note
    @@log.info{"note #{note} on"}
  end

  def removeFromCurrentChord note
    @model.delete note
    @@log.info{"note #{note} off"}
  end

end
