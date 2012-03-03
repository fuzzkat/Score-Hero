class NoteModel
  NOTES = [
    {:name => "C", :white_key_index => 0},
    {:name => "C#", :white_key_index => 0},
    {:name => "D", :white_key_index => 1},
    {:name => "D#", :white_key_index => 1},
    {:name => "E", :white_key_index => 2},
    {:name => "F", :white_key_index => 3},
    {:name => "F#", :white_key_index => 3},
    {:name => "G", :white_key_index => 4},
    {:name => "G#", :white_key_index => 4},
    {:name => "A", :white_key_index => 5},
    {:name => "A#", :white_key_index => 5},
    {:name => "B", :white_key_index => 6}
  ]

  def initialize note
    @note = note.to_i
  end

  def name
    NoteModel.name_of @note
  end

  def midi_pitch
    @note
  end
  
  def NoteModel.name_of note
    NOTES[note%12][:name] + octave_of(note).to_s
  end

  def octave
    NoteModel.octave_of @note
  end

  def NoteModel.octave_of note
    (note/12-1).to_i
  end

  def whitekey_index
    NoteModel.whitekey_index_of @note
  end

  def NoteModel.whitekey_index_of note
    NOTES[note%12][:white_key_index]
  end

end