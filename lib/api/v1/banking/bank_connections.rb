# frozen_string_literal: true

module Api
  module V1
    module Banking
      # This class is responsible for all the API calls related to banking bank connections.
      class BankConnections < Api::V1::Base
        def by(id:)
          get("#{@url_api_path}/banking/bank_connections/#{id}")
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

          get("#{@url_api_path}/banking/bank_connections", query)
        end
      end
    end
  end
end
