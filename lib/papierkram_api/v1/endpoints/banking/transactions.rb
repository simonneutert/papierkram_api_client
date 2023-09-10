# frozen_string_literal: true

module PapierkramApi
  module V1
    module Endpoints
      module Banking
        # This class is responsible for all the API calls related to banking transactions.
        class Transactions < PapierkramApi::V1::Endpoints::Base
          def find_by(id:)
            http_get("#{@url_api_path}/banking/transactions/#{id}")
          end

          def all(bank_connection_id:,
                  page: 1,
                  page_size: 100,
                  order_by: nil,
                  order_direction: nil)
            query = {
              bank_connection_id: bank_connection_id,
              page: page,
              page_size: page_size
            }
            query[:order_by] = order_by if order_by
            query[:order_direction] = order_direction if order_direction

            http_get("#{@url_api_path}/banking/transactions", query)
          end
        end
      end
    end
  end
end
