module SolutionsInfini
  class << self
    attr_accessor :si_api_key, :si_sender
    
    def configure
      yield self
    end
  end  
end
