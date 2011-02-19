require File.expand_path(File.dirname(__FILE__) + '/test_helper')

require 'tune_view'
require 'controller'
require 'tune_controller'
require 'mock_screen'
require 'stave_view'

class TC_TuneView < Test::Unit::TestCase
  def setup
    @tune_model = [Note.new(60),Note.new(68),Note.new(64),Note.new(52)]
  end

  def test_add_sub_view
    unit = TuneView.new(@tune_model, TuneController.new(nil))
    unit.note_view = NoteViewWrapper
    unit.super_view = "Stave View"
    unit.add_sub_view()

    sub_views = unit.sub_views()

    assert_equal(4, sub_views.size)

    assert_equal("Stave View", sub_views[0].stave_view)
    assert_equal("Stave View", sub_views[1].stave_view)
    assert_equal("Stave View", sub_views[2].stave_view)
    assert_equal("Stave View", sub_views[3].stave_view)

    assert_equal(60, sub_views[0].model.midi_pitch)
    assert_equal(68, sub_views[1].model.midi_pitch)
    assert_equal(64, sub_views[2].model.midi_pitch)
    assert_equal(52, sub_views[3].model.midi_pitch)
  end

  def test_render
    tune_controller = TuneController.new(nil)
    tune_controller.pos=5
    
    unit = TuneView.new(@tune_model, tune_controller)
    unit.note_view = NoteViewWrapper
    unit.add_sub_view()
    unit.set_draw_area(0,0,640,200)
    assert_equal 4, unit.sub_views().size
    
    screen = MockScreen.new
    unit.render screen

    assert_equal(screen, unit.sub_views[0].screen)
    assert_equal(screen, unit.sub_views[1].screen)
    assert_equal(screen, unit.sub_views[2].screen)
    assert_equal(screen, unit.sub_views[3].screen)
    
    assert_equal(320 + (0-5)*40, unit.sub_views[0].rendered_at)
    assert_equal(320 + (1-5)*40, unit.sub_views[1].rendered_at)
    assert_equal(320 + (2-5)*40, unit.sub_views[2].rendered_at)
    assert_equal(320 + (3-5)*40, unit.sub_views[3].rendered_at)
  end

  class NoteViewWrapper < NoteView
    attr_reader :stave_view, :rendered_at, :screen
    
    def render screen, pos
      @screen = screen
      @rendered_at = pos
    end
  end

end