require 'logger'

class AppLogger
  
  @@log = nil
  
  def AppLogger.get_logger
    if @@log.nil?
      @@log = Logger.new(STDOUT)
      @@log.level = Logger::WARN
    end
    @@log
  end
end