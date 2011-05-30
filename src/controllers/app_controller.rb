require 'controller'

require 'stave_view'

require 'keypress_model'
require 'keypress_view'
require 'keypress_controller'

require 'random_tune_model'
require 'tune_view'
require 'tune_controller'

class AppController < Controller
  TEMPO = 40
  
  def construct_mvc_map midi_input
    @midi_input = midi_input
    stave_view = StaveView.new(nil, Controller.new)
    view.add_sub_view(stave_view)
    
    construct_and_add_tune_mvc_to(stave_view)
#    tune_model = RandomTuneModel.new
#    tune_controller = TuneController.new(TEMPO)
#    tune_view = TuneView.new(tune_model, tune_controller)
#    stave_view.add_sub_view(tune_view)
#    tune_view.add_sub_view()
    
    construct_and_add_keypress_mvc_to(stave_view)
  end
  
  def construct_and_add_tune_mvc_to view
    tune_model = RandomTuneModel.new
    tune_controller = TuneController.new(TEMPO)
    tune_view = TuneView.new(tune_model, tune_controller)
    view.add_sub_view(tune_view)
    tune_view.add_sub_view()
  end
  
  def construct_and_add_keypress_mvc_to stave_view
    keypress_model = KeypressModel.new
    keypress_controller = KeypressController.new(@midi_input)
    keypress_view = KeypressView.new(keypress_model, keypress_controller)
    stave_view.add_sub_view(keypress_view)
  end
end

#class AppController < Controller
#  TEMPO = 40
#  
#  def construct_mvc_map midi_input
#    @midi_input = midi_input
#    
#    stave_view = StaveView.new(nil, Controller.new)
#    
#    view.add_sub_view(stave_view)
#    
#    construct_and_add_tune_mvc_to(stave_view)
#    construct_and_add_keypress_mvc_to(stave_view)
#  end
#  
#  def construct_and_add_tune_mvc_to view
#    tune_model = RandomTuneModel.new
#    tune_controller = TuneController.new(TEMPO)
#    tune_view = TuneView.new(tune_model, tune_controller)
#    tune_view.add_sub_view()
#    view.add_sub_view(tune_view)
#  end
#  
#  def construct_and_add_keypress_mvc_to view
#    keypress_model = KeypressModel.new
#    keypress_controller = KeypressController.new(@midi_input)
#    keypress_view = KeypressView.new(keypress_model, keypress_controller)
#    view.add_sub_view(keypress_view)
#  end
#end