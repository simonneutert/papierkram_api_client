# frozen_string_literal: true

module PapierkramApi
  module V1
    module Endpoints
      module Income
        # This class is responsible for all the API calls related to income propositions.
        class Propositions < PapierkramApi::V1::Endpoints::Base
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
end
