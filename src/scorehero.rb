$: << File.expand_path(File.dirname(__FILE__) + "/../src")

# Here are several ways you can use SDL.inited_system
require 'note'
require 'note_view'
require 'keypress_view'
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
CROCHET_GAP = WHITE_NOTE_HEIGHT*6

@speed = 100

Portmidi.start

subsystem_init = SDL.inited_system(SDL::INIT_EVERYTHING)
if !(subsystem_init & SDL::INIT_VIDEO)
  puts "video initialisation Failed"
  halt
end

#Portmidi.input_devices.each do |dev|
#  puts "%d > %s" % [dev.device_id, dev.name]
#end
#puts "choose input device id"
#device_id = gets()
device_id = 3

midi_input = Portmidi::Input.new(device_id.to_i)

screen = SDL::Screen.open(SCREEN_WIDTH, SCREEN_HEIGHT, 0, SDL::HWSURFACE || SDL::DOUBLEBUF || SDL::RESIZABLE || SDL::ASYNCBLIT)
SDL::WM.set_caption "Score Hero", "Score Hero"

screen.draw_rect 0, 0, SCREEN_WIDTH, BORDER_SIZE, [120,0,0], true  
screen.draw_rect 0, SCREEN_HEIGHT-BORDER_SIZE, SCREEN_WIDTH, BORDER_SIZE, [120,0,0], true

#tune = (0..40).collect{ |x|
#  [Note.new(60+x),x*WHITE_NOTE_HEIGHT*6+SCREEN_WIDTH]
#}

tune = (0..100).collect { |x|
  [Note.new(60+rand(25)),x*CROCHET_GAP+SCREEN_WIDTH]
}
pos = 0

stave = Stave.new(MIDDLE_C_POS, WHITE_NOTE_HEIGHT)

@pressed_keys = []

def render screen, stave, tune, display_offset
  screen.draw_rect 0, BORDER_SIZE, SCREEN_WIDTH, SCREEN_HEIGHT-BORDER_SIZE*2, [255,255,255], true
  
  stave.render screen, SCREEN_WIDTH
  screen.draw_rect(SCREEN_WIDTH/2-10,MIDDLE_C_POS+WHITE_NOTE_HEIGHT*2,20,WHITE_NOTE_HEIGHT*-16,[255,0,0])
  
  tune.each { |note, note_pos|
    NoteView.new(note).render(screen, note_pos - display_offset, MIDDLE_C_POS, WHITE_NOTE_HEIGHT)
  }
  
  @pressed_keys.each{ |midi_note|
    KeypressView.render(midi_note, screen, SCREEN_WIDTH/2, MIDDLE_C_POS, WHITE_NOTE_HEIGHT)
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
        @pressed_keys << note
        log.info(note)
      else
        @pressed_keys = @pressed_keys - [note] 
      end
    }
  end
  render screen, stave, tune, pos
  if log.info?
    fps += 1
    if Time.new.to_f >= frame_timer.to_f + Time.at(1).to_f
      log.info fps.to_s + " fps"
      fps = 0
      frame_timer = Time.new
    end
  end
end
