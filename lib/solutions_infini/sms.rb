module SolutionsInfini
  class Sms

    include HTTParty

    BASE_URL = "http://alerts.solutionsinfini.com/api/v3/index.php"

    def self.send_sms(params_hash)
      #usage: SolutionsInfini::Sms.send_sms({to: '9xxxxxxx', message: "welcome to mysite"})
      errors = []
      if valid?(params_hash, errors)
        #submit request to provider
        response = HTTParty.post("#{BASE_URL}", body: {method: :sms, api_key: SolutionsInfini.si_api_key, to: params_hash[:to_number], sender: SolutionsInfini.si_sender, message: params_hash[:message], format: :json})
        handle_response_on_send(response)
      else
        #raise error saying params not valid
        raise SolutionsInfini::ParamsError, errors
      end
    end

    def self.get_details(params_hash)
      if params_hash[:sid].present?
        #get status from provider
        response = HTTParty.post(BASE_URL, body: {method: "sms.status", api_key: SolutionsInfini.si_api_key, format: :json, id: params_hash[:sid]})
        handle_response_on_status(response)
      else
        #raise invalid argument error
        raise SolutionsInfini::ParamsError, "sid is mandatory"
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

      def self.handle_response_on_send(response)
        res = response.parsed_response
        case res["status"]
        when "OK" then OpenStruct.new({sid: res["data"]["0"]["id"]})
        else
          raise SolutionsInfini::UnexpectedError, res
        end
      end

      def self.handle_response_on_status(response)
        res = response.parsed_response
        case res["status"]
        when "OK" then
          data = res["data"].first
          OpenStruct.new({sid: data["id"], status: data["status"], number: data["mobile"], sent_at: data["senttime"], delivered_at: data["dlrtime"]})
        else
          raise SolutionsInfini.UnexpectedError, res
        end
      end

  end

end
