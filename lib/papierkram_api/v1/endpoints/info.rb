# frozen_string_literal: true

module PapierkramApi
  module V1
    module Endpoints
      # This class is responsible for all the API calls related to info connections.
      class Info < PapierkramApi::V1::Endpoints::Base
        def details
          get("#{@url_api_path}/info")
        end
      end
    end
  end
end
