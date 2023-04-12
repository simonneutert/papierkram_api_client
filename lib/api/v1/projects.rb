# frozen_string_literal: true

module Api
  module V1
    # This class is responsible for all the API calls related to projects connections.
    class Projects < Api::V1::Base
      def by(id:)
        get("#{@url_api_path}/projects/#{id}")
      end

      def all(page: 1, per_page: 100, order_by: nil, order_direction: nil, company_id: nil)
        query = {
          page: page,
          per_page: per_page
        }
        query[:order_by] = order_by if order_by
        query[:order_direction] = order_direction if order_direction
        query[:company_id] = company_id if company_id

        get("#{@url_api_path}/projects", query)
      end
    end
  end
end
