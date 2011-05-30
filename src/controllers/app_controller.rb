require 'controller'
require 'random_tune_model'

class AppController < Controller
  def setup midi_input
    tempo = 40
    
    stave_view = StaveView.new(nil, Controller.new)
    view.add_sub_view(stave_view)
    
    tune_model = RandomTuneModel.new
    tune_controller = TuneController.new(tempo)
    tune_view = TuneView.new(tune_model, tune_controller)
    stave_view.add_sub_view(tune_view)
    tune_view.add_sub_view()
    
    keypress_model = KeypressModel.new
    keypress_controller = KeypressController.new(midi_input)
    keypress_view = KeypressView.new(keypress_model, keypress_controller)
    stave_view.add_sub_view(keypress_view)
  end
end