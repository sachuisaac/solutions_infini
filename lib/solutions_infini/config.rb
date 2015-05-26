module SolutionsInfini
  class << self
    attr_accessor :si_api_key, :si_sender
    
    def configure
      yield self
    end
  end

  class UnexpectedError < StandardError;  end
  class ParamsError < StandardError;  end

end
