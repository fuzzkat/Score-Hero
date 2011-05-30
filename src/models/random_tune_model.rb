class RandomTuneModel < Array
  def initialize
    self << (0..100).collect { |x| Note.new(60+rand(23)) }
  end
end