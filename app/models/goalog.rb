class Goalog
  
  def self.error m
    Rails.logger.error "[goalog:error] #{m}"
  end
  
  def self.critical m
    Rails.logger.error "[goalog:critical] #{m}"
  end
  
  def self.info m
    Rails.logger.info "[goalog:info] #{m}"
  end
  
  def self.debug m
    Rails.logger.debug "[goalog:debug] #{m}"
  end
  
  def self.exception e
    Rails.logger.info "[goalog:exception] #{e.message}"
    Rails.logger.info "[goalog:exception] #{e.backtrace.join("\n")}"
  end
  
  def self.critical_exception m, e
    critical m
    exception e
  end
  
end
