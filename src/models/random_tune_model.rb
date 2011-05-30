require 'note'

class RandomTuneModel < Array
  def initialize
    (0..99).each { |x| self << Note.new(60+rand(23)) }
  end
end