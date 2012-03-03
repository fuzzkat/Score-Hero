require 'note_model'

class RandomTuneModel < Array
  def initialize
    (0..99).each { |x| self << NoteModel.new(60+rand(23)) }
  end
end