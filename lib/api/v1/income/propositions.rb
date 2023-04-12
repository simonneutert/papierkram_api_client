# frozen_string_literal: true

module Api
  module V1
    module Income
      # This class is responsible for all the API calls related to income propositions.
      class Propositions < Api::V1::Base
        def by(id:)
          get("#{@url_api_path}/income/propositions/#{id}")
        end

        def all
          get("#{@url_api_path}/income/propositions")
        end
      end
    end
  end
end
