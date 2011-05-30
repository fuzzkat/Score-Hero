class KeypressModel
  
  attr_accessor :chord
  
  def initialize
    @observers = []
    @chord = []
  end
  
  def press key
    @observers.each do |observer|
      observer.notify(key)
    end
    @chord << key
  end
  
  def release key
    @chord.delete(key)
  end
  
  def registerObserver(observer)
    @observers << observer
  end
end