$: << File.expand_path(File.dirname(__FILE__) + "/../src")
$: << File.expand_path(File.dirname(__FILE__) + "/../src/models")
$: << File.expand_path(File.dirname(__FILE__) + "/../src/views")
$: << File.expand_path(File.dirname(__FILE__) + "/../src/controllers")

# Here are several ways you can use SDL.inited_system
require 'app_view'
require 'app_controller'

require 'stave_view'

require 'keypress_model'
require 'keypress_view'
require 'keypress_controller'

require 'tune_view'
require 'tune_controller'

require 'sdl'
require 'portmidi'
require 'logger'

log = AppLogger.get_logger()

screen_width = 800
screen_height = 300

Portmidi.start

subsystem_init = SDL.inited_system(SDL::INIT_EVERYTHING)
if !(subsystem_init & SDL::INIT_VIDEO)
  puts "video initialisation Failed"
  halt
end

device_id = 3
found = false

Portmidi.input_devices.each do |dev|
  if dev.device_id == device_id
    selected = "<-- Selected"
    found = true
  else
    selected = ""
  end
   
  puts "%d > %s %s" % [dev.device_id, dev.name, selected]
end

if !found
  puts "choose input device id"
  device_id = gets()
end

midi_input = Portmidi::Input.new(device_id.to_i)

screen = SDL::Screen.open(screen_width, screen_height, 0, SDL::HWSURFACE || SDL::DOUBLEBUF || SDL::RESIZABLE || SDL::ASYNCBLIT)
SDL::WM.set_caption "Score Hero", "Score Hero"

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

app_controller = AppController.new
app_view = AppView.new(nil, app_controller)
app_controller.setup(midi_input)

app_view.set_draw_area(0,0,screen_width,screen_height)

if log.info?
  fps = 0
  frame_timer = Time.new
end

while true
  app_controller.open
  app_view.render screen
end
