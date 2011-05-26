$: << File.expand_path(File.dirname(__FILE__) + "/../src")
$: << File.expand_path(File.dirname(__FILE__) + "/../src/models")
$: << File.expand_path(File.dirname(__FILE__) + "/../src/views")
$: << File.expand_path(File.dirname(__FILE__) + "/../src/controllers")

# Here are several ways you can use SDL.inited_system
require 'app_view'
require 'app_controller'

require 'stave_view'

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
tempo = 40

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

#tune = (0..40).collect{ |x|
#  [Note.new(60+x),x]
#}


#pos = 0

@pressed_keys = []

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

stave_view = StaveView.new(nil, Controller.new)
app_view.add_sub_view(stave_view)

tune_model = (0..100).collect { |x| Note.new(60+rand(23)) }
tune_controller = TuneController.new(tempo)
tune_view = TuneView.new(tune_model, tune_controller)
stave_view.add_sub_view(tune_view)
tune_view.add_sub_view()

keypress_model = []
keypress_controller = KeypressController.new(midi_input)
keypress_view = KeypressView.new(keypress_model, keypress_controller)
stave_view.add_sub_view(keypress_view)

app_view.set_draw_area(0,0,screen_width,screen_height)

if log.info?
  fps = 0
  frame_timer = Time.new
end

#anim_timer = Time.new
while true
#  time_pos = Time.new - anim_timer
#  pos = time_pos * @tempo/60
#  if pos > tune.size + 11
#    anim_timer = Time.new
#  end
#  log.debug("Position: " + pos.to_s)
  
  app_controller.open
  app_view.render screen
  
#  if log.info?
#    fps += 1
#    if Time.new.to_f >= frame_timer.to_f + Time.at(1).to_f
#      log.info fps.to_s + " fps"
#      fps = 0
#      frame_timer = Time.new
#    end
#  end
end
