class KeypressModel
  
  attr_accessor :chord
  
  def initialize
    @observers = []
    @chord = []
    @@log = AppLogger.get_logger()
  end
  
  def press key
    @observers.each do |observer|
      observer.notify(key)
    end
    @chord << key
    @@log.info{"note #{note} on"}
  end
  
  def release key
    @chord.delete(key)
    @@log.info{"note #{note} off"}
  end
  
  def registerObserver(observer)
    @observers << observer
  end
end