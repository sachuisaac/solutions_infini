class Sms

  include HTTParty

  BASE_URL = "https://alerts.solutionsinfini.com/api/v3/index.php"

  def self.send_sms(params_hash)
    errors = []
    if valid?(params_hash, errors)
      #submit request to provider
      response = HTTParty.post("#{BASE_URL}", body: {method: :sms, api_key: SolutionsInfini.si_api_key, to: params_hash[:to_number], sender: SolutionsInfini.si_sender, message: params_hash[:message], format: :json})
      handle_response(response)
    else
      #raise error saying params not valid
      raise SolutionsInfini::ParamsError, errors
    end
  end

  def self.get_status(params)
    if params.is_a? Array
      #get array of status from provider
    elsif params.is_a? String
      #get status from provider
    else
      #raise invalid argument error
    end
  end

  private

    def self.valid?(params_hash, errors)
      errors = []
      if !(params_hash[:to_number].present? && params_hash[:to_number].length >= 10)
        errors << "to_number should be at least 10 digits"
      end
      if params_hash[:message].blank?
        errors << "message cannot be empty"
      end
      res = errors.blank? ? true : false
      return res
    end

    def handle_response(response)
      res = response.parsed_response
      case res["status"]
      when "OK" then {sid: res["data"]["0"]["id"]}
      else
        raise SolutionsInfini::UnexpectedError, res
      end
    end

end
