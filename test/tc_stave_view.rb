require File.expand_path(File.dirname(__FILE__) + '/test_helper')

require 'stave_view'
require 'controller'
require 'mock_screen'

class TC_StaveView < Test::Unit::TestCase
  RED = [255,0,0]
  
  def test_render
    screen = MockScreen.new

    unit = StaveView.new nil, Controller.new
    unit.set_draw_area(0,0,600,150)

    unit.render screen

    assert_equal([0,65,600,65,0], screen.lines[0])
    assert_equal([0,55,600,55,0], screen.lines[1])
    assert_equal([0,45,600,45,0], screen.lines[2])
    assert_equal([0,35,600,35,0], screen.lines[3])
    assert_equal([0,25,600,25,0], screen.lines[4])
    
    assert_equal([290,75,20,-60,RED,false,nil], screen.rects[0])
  end

  def test_get_relative_y_pos_of
    unit = StaveView.new nil, Controller.new
    unit.set_draw_area(0,0,600,150)
    
    assert_equal(0, unit.get_relative_y_pos_of(60))
    assert_equal(0, unit.get_relative_y_pos_of(61))
    assert_equal(5, unit.get_relative_y_pos_of(62))
    assert_equal(5, unit.get_relative_y_pos_of(63))
    assert_equal(10, unit.get_relative_y_pos_of(64))
    assert_equal(15, unit.get_relative_y_pos_of(65))
  end

  def test_leger_lines_off_stave_bottom
    unit = StaveView.new nil, Controller.new
    unit.set_draw_area(0,0,480,300)
        
    assert_equal([-20,0], unit.ledger_lines(Note.new(55)) ) #G3
    assert_equal([-20,0], unit.ledger_lines(Note.new(57)) ) #A3
    assert_equal([0], unit.ledger_lines(Note.new(59)) ) #B3
    assert_equal([0], unit.ledger_lines(Note.new(60)) ) #C4
    assert_equal([], unit.ledger_lines(Note.new(62)) ) #D4
    assert_equal([], unit.ledger_lines(Note.new(64)) ) #E4
    assert_equal([], unit.ledger_lines(Note.new(66)) ) #F4
  end

  def test_leger_lines_off_stave_top
    unit = StaveView.new nil, Controller.new
    unit.set_draw_area(0,0,480,300)
    
    assert_equal([], unit.ledger_lines(Note.new(77)) ) #F4
    assert_equal([], unit.ledger_lines(Note.new(79)) ) #G4
    assert_equal([120], unit.ledger_lines(Note.new(81)) ) #A4
    assert_equal([120], unit.ledger_lines(Note.new(83)) ) #B4
    assert_equal([120,140], unit.ledger_lines(Note.new(84)) ) #C5
    assert_equal([120,140], unit.ledger_lines(Note.new(86)) ) #D5
    assert_equal([120,140,160], unit.ledger_lines(Note.new(88)) ) #E5
    assert_equal([120,140,160], unit.ledger_lines(Note.new(89)) ) #F5
  end

end