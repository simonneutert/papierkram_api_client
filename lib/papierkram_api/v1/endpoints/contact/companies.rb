# frozen_string_literal: true

module PapierkramApi
  module V1
    module Endpoints
      module Contact
        # This class is responsible for all the API calls related to banking bank connections.
        class Companies < PapierkramApi::V1::Endpoints::Base
          def by(id:)
            get("#{@url_api_path}/contact/companies/#{id}")
          end

          def all(page: 1,
                  page_size: 100,
                  order_by: nil,
                  order_direction: nil)
            query = {
              page: page,
              page_size: page_size
            }
            query[:order_by] = order_by if order_by
            query[:order_direction] = order_direction if order_direction

            get("#{@url_api_path}/contact/companies", query)
          end
        end
      end
    end
  end
end
