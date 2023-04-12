# frozen_string_literal: true

module Api
  module V1
    # This class is responsible for all the API calls related to info connections.
    class Info < Api::V1::Base
      def details
        get("#{@url_api_path}/info")
      end
    end
  end
end
