$: << File.expand_path(File.dirname(__FILE__) + "/../src")

# Here are several ways you can use SDL.inited_system
require 'note'
require 'sdl'
require 'portmidi'

SCREEN_WIDTH = 800
SCREEN_HEIGHT = 400
BORDER_SIZE = SCREEN_HEIGHT/20
LINE_HEIGHT = 10
MIDDLE_C_POS = SCREEN_HEIGHT/2+LINE_HEIGHT*6
NOTES = ["C","C#/Db","D","D#/Eb","E","F","F#/Gb","G","G#/Ab","A","A#/Bb","B"]
@speed = 30

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

midi_input = Portmidi::Input.new(device_id.to_i)

screen = SDL::Screen.open(SCREEN_WIDTH, SCREEN_HEIGHT, 0, SDL::HWSURFACE || SDL::DOUBLEBUF || SDL::RESIZABLE || SDL::ASYNCBLIT)
SDL::WM.set_caption "Score Hero", "Score Hero"

screen.draw_rect 0, 0, SCREEN_WIDTH, BORDER_SIZE, [120,0,0], true  
screen.draw_rect 0, SCREEN_HEIGHT-BORDER_SIZE, SCREEN_WIDTH, BORDER_SIZE, [120,0,0], true

notes = (0..100).collect { |x|
  [Note.new(60+rand(25)),x*LINE_HEIGHT*6+SCREEN_WIDTH]
}
pos = 0

@current_notes = []

def render screen, notes, display_offset
  screen.draw_rect 0, BORDER_SIZE, SCREEN_WIDTH, SCREEN_HEIGHT-BORDER_SIZE*2, [255,255,255], true
  
  draw_stave screen, MIDDLE_C_POS, LINE_HEIGHT
  
  notes.each { |note, note_pos|
    note.render(screen, note_pos - display_offset, MIDDLE_C_POS, LINE_HEIGHT)
  }
  
  @current_notes.each{ |note|
    Note.new(note).render_keypress(screen, SCREEN_WIDTH/2, MIDDLE_C_POS, LINE_HEIGHT)
  }
      
  screen.flip
end

def draw_stave screen, middle_c_pos, line_height
  (0..4).each do |line|
    line_y = middle_c_pos - (line+1)*line_height*2
    screen.draw_line 0,line_y,SCREEN_WIDTH,line_y,0  
    end
  
  screen.draw_rect(SCREEN_WIDTH/2-10,MIDDLE_C_POS+LINE_HEIGHT*2,20,line_height*-16,[255,0,0])
end

animate_thread = Thread.new {
  timer = Time.new
  while true
    time_pos = Time.new - timer
    pos = time_pos * @speed
    if pos > SCREEN_WIDTH + 6000 + LINE_HEIGHT*1.35
      timer = Time.new
    end
  end
}

#fps = 0
#frame_timer = Time.new
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
      
#    fps += 1
#    if Time.new.to_f >= frame_timer.to_f + Time.at(1).to_f
#      puts fps
#      fps = 0
#      frame_timer = Time.new
#    end
  end
}

while true
  midi_events = midi_input.read(16)
  if !midi_events.nil?
    midi_events.each{|e|
      note = e[:message][1].to_i
      if e[:message][2] > 0
        @current_notes << note
      else
        @current_notes = @current_notes - [note] 
      end
    }
  end
  
  render screen, notes, pos
end
