require File.expand_path(File.dirname(__FILE__) + '/test_helper')
require 'tune_view'
require 'controller'
require 'tune_controller'
require 'mock_screen'
require 'stave_view'

class TC_TuneView < Test::Unit::TestCase

  def test_add_sub_view
    unit = construct_tune_view

    sub_views = unit.sub_views()

    assert_equal(4, sub_views.size)

    assert_equal(60, sub_views[0].model.midi_pitch)
    assert_equal(68, sub_views[1].model.midi_pitch)
    assert_equal(64, sub_views[2].model.midi_pitch)
    assert_equal(52, sub_views[3].model.midi_pitch)
  end

  def test_render
    unit = construct_tune_view
    
    unit.set_draw_area(0,0,640,200)
    
    assert_equal 4, unit.sub_views().size

    screen = MockScreen.new
    unit.render screen

    assert_equal(screen, unit.sub_views[0].screen)
    assert_equal(screen, unit.sub_views[1].screen)
    assert_equal(screen, unit.sub_views[2].screen)
    assert_equal(screen, unit.sub_views[3].screen)

    assert_equal([320 + (0-5)*40,100], unit.sub_views[0].rendered_at)
    assert_equal([320 + (1-5)*40,100], unit.sub_views[1].rendered_at)
    assert_equal([320 + (2-5)*40,100], unit.sub_views[2].rendered_at)
    assert_equal([320 + (3-5)*40,100], unit.sub_views[3].rendered_at)
  end

  def construct_tune_view
    tune_model = [NoteModel.new(60),NoteModel.new(68),NoteModel.new(64),NoteModel.new(52)]
    
    tune_controller = TuneController.new(nil)
    tune_controller.pos=5

    unit = TuneView.new(tune_model, tune_controller)
    unit.note_view = NoteViewWrapper
    unit.super_view = MockStaveView.new
    unit.super_view.middle_c_pos = 100
    unit.add_notes_as_sub_views
    return unit
  end
  
  class MockStaveView
    attr_accessor :middle_c_pos
  end

  class NoteViewWrapper < NoteView
    attr_reader :stave_view, :rendered_at, :screen
    def render screen, x, y
      @screen = screen
      @rendered_at = [x,y]
    end
  end

end