require 'controller'

class TuneController < Controller
  attr_accessor :pos
  def initialize tempo
    @tempo = tempo
    @tune_start_time = get_time()
  end

  def open
    super
    calculate_position_in_tune()
    #reset_if_tune_finished()
  end

  private

  def reset_if_tune_finished()
    if @pos > @model.size + 11
      reset_tune()
    end
  end

  def reset_tune()
    @tune_start_time = get_time
  end
  
  def calculate_position_in_tune()
    seconds_since_start = get_time() - @tune_start_time
    @pos = seconds_since_start * @tempo/60
  end

  def get_time
    Time.new
  end
end