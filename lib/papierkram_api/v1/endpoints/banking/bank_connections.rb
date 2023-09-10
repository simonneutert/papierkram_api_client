# frozen_string_literal: true

require_relative '../base'

module PapierkramApi
  module V1
    module Endpoints
      module Banking
        # This class is responsible for all the API calls related to banking bank connections.
        class BankConnections < PapierkramApi::V1::Endpoints::Base
          def find_by(id:)
            http_get("#{@url_api_path}/banking/bank_connections/#{id}")
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

            http_get("#{@url_api_path}/banking/bank_connections", query)
          end
        end
      end
    end
  end
end
