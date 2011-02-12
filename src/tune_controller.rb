require 'controller'

class TuneController < Controller
  attr_accessor :pos
  
  def initialize tempo
    @tempo = tempo
    @tune_start_time = get_time()
  end
  
  def open
    super
    time_pos = get_time - @tune_start_time
    @pos = time_pos * @tempo/60
    
#    if @pos > @model.size + 11
#      @tune_start_time = get_time
#    end
  end
  
  private
  
  def get_time
    Time.new
  end
end