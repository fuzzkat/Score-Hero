class MockScreen
  def initialize
    @ellipses = []
    @rects = []
    @lines = []
  end

  def draw_ellipse x,y,rx,ry,color, fill=false, aa=false, alpha=nil
    @ellipses << [x,y,rx,ry,color,fill,aa,alpha]
  end

  def ellipses
    @ellipses
  end

  def draw_rect(x,y,w,h,color,fill=false,alpha=nil)
    @rects << [x,y,w,h,color,fill,alpha]
  end

  def rects
    @rects
  end

  def draw_line x1,y1,x2,y2,colour
    @lines << [x1,y1,x2,y2,colour]
  end

  def lines
    @lines
  end
end
