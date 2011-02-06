$: << File.expand_path(File.dirname(__FILE__) + "/../src")

# Here are several ways you can use SDL.inited_system
require 'app_model'
require 'app_view'
require 'app_controller'

require 'stave_view'

require 'keypress_view'
require 'keypress_controller'

require 'sdl'
require 'portmidi'
require 'logger'

log = AppLogger.get_logger()

screen_width = 800
screen_height = 300

@tempo = 120

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

screen = SDL::Screen.open(screen_width, screen_height, 0, SDL::HWSURFACE || SDL::DOUBLEBUF || SDL::RESIZABLE || SDL::ASYNCBLIT)
SDL::WM.set_caption "Score Hero", "Score Hero"

#tune = (0..40).collect{ |x|
#  [Note.new(60+x),x]
#}

tune = (0..100).collect { |x|
  [60+rand(25),x]
}
pos = 0

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
app_model = AppModel.new

app_view = AppView.new(app_model, app_controller)

stave_view = StaveView.new(nil, Controller.new)
app_view.add_sub_view(stave_view)

keypress_model = []
keypress_controller = KeypressController.new(midi_input)
keypress_view = KeypressView.new(keypress_model, keypress_controller)
stave_view.add_sub_view(keypress_view)

app_view.set_draw_area(0,0,screen_width,screen_height)

if log.info?
  fps = 0
  frame_timer = Time.new
end

anim_timer = Time.new

while true
  time_pos = Time.new - anim_timer
  pos = time_pos * @tempo/60
  if pos > tune.size + 11
    anim_timer = Time.new
  end
  log.debug("Position: " + pos.to_s)
  
  app_controller.open
  app_view.render screen
  
  if log.info?
    fps += 1
    if Time.new.to_f >= frame_timer.to_f + Time.at(1).to_f
      log.info fps.to_s + " fps"
      fps = 0
      frame_timer = Time.new
    end
  end
end
