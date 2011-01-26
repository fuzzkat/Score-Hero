$: << File.expand_path(File.dirname(__FILE__) + "/../src")

# Here are several ways you can use SDL.inited_system
require 'note'
require 'stave'
require 'sdl'
require 'portmidi'
require 'logger'

log = Logger.new(STDOUT)
log.level = Logger::WARN

SCREEN_WIDTH = 800
SCREEN_HEIGHT = 300
BORDER_SIZE = SCREEN_HEIGHT/20
WHITE_NOTE_HEIGHT = SCREEN_HEIGHT/24
MIDDLE_C_POS = SCREEN_HEIGHT/2+WHITE_NOTE_HEIGHT*6
NOTES = ["C","C#/Db","D","D#/Eb","E","F","F#/Gb","G","G#/Ab","A","A#/Bb","B"]
@speed = 50

Portmidi.start

subsystem_init = SDL.inited_system(SDL::INIT_EVERYTHING)
if !(subsystem_init & SDL::INIT_VIDEO)
  puts "video initialisation Failed"
  halt
end

Portmidi.input_devices.each do |dev|
  puts "%d > %s" % [dev.device_id, dev.name]
end
puts "choose input device id"
device_id = gets()
#device_id = 3

midi_input = Portmidi::Input.new(device_id.to_i)

screen = SDL::Screen.open(SCREEN_WIDTH, SCREEN_HEIGHT, 0, SDL::HWSURFACE || SDL::DOUBLEBUF || SDL::RESIZABLE || SDL::ASYNCBLIT)
SDL::WM.set_caption "Score Hero", "Score Hero"

screen.draw_rect 0, 0, SCREEN_WIDTH, BORDER_SIZE, [120,0,0], true  
screen.draw_rect 0, SCREEN_HEIGHT-BORDER_SIZE, SCREEN_WIDTH, BORDER_SIZE, [120,0,0], true

#notes = (0..40).collect{ |x|
#  [Note.new(60+x),x*WHITE_NOTE_HEIGHT*6+SCREEN_WIDTH]
#}

notes = (0..100).collect { |x|
  note_val = 60+rand(25)
  [Note.new(note_val),x*WHITE_NOTE_HEIGHT*6+SCREEN_WIDTH]
}
pos = 0

stave = Stave.new()

@current_notes = []

def render screen, stave, notes, display_offset
  screen.draw_rect 0, BORDER_SIZE, SCREEN_WIDTH, SCREEN_HEIGHT-BORDER_SIZE*2, [255,255,255], true
  
  stave.render screen, MIDDLE_C_POS, WHITE_NOTE_HEIGHT
  
  notes.each { |note, note_pos|
    note.render(screen, note_pos - display_offset, MIDDLE_C_POS, WHITE_NOTE_HEIGHT)
  }
  
  @current_notes.each{ |note|
    Note.new(note).render_keypress(screen, SCREEN_WIDTH/2, MIDDLE_C_POS, WHITE_NOTE_HEIGHT)
  }
      
  screen.flip
end

animate_thread = Thread.new {
  timer = Time.new
  while true
    time_pos = Time.new - timer
    pos = time_pos * @speed
    if pos > SCREEN_WIDTH + 6000 + WHITE_NOTE_HEIGHT*1.35
      timer = Time.new
    end
  end
}

event_thread = Thread.new {
  while true
    while event = SDL::Event.poll
      case event
      when SDL::Event::Quit
        exit
      when SDL::Event::KeyDown
        exit if event.sym == 113
      end
    end
  end
}


if log.info?
  fps = 0
  frame_timer = Time.new
end

while true
  midi_events = midi_input.read(16)
  if !midi_events.nil?
    midi_events.each{|e|
      note = e[:message][1].to_i
      if e[:message][2] > 0
        @current_notes << note
        log.info(note)
      else
        @current_notes = @current_notes - [note] 
      end
    }
  end
  render screen, stave, notes, pos
  if log.info?
    fps += 1
    if Time.new.to_f >= frame_timer.to_f + Time.at(1).to_f
      log.info fps.to_s + " fps"
      fps = 0
      frame_timer = Time.new
    end
  end
end