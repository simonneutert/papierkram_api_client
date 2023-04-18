# frozen_string_literal: true

module PapierkramApi
  module V1
    module Endpoints
      module Tracker
        # This class is responsible for all the API calls related to tracker tasks connections.
        class Tasks < PapierkramApi::V1::Endpoints::Base
          def by(id:)
            get("#{@url_api_path}/tracker/tasks/#{id}")
          end

          def all(page: 1,
                  page_size: 100,
                  order_by: nil,
                  order_direction: nil,
                  project_id: nil,
                  proposition_id: nil)
            query = {
              page: page,
              page_size: page_size
            }
            query[:order_by] = order_by if order_by
            query[:order_direction] = order_direction if order_direction
            query[:project_id] = project_id if project_id
            query[:proposition_id] = proposition_id if proposition_id
            get("#{@url_api_path}/tracker/tasks", query)
          end
        end
      end
    end
  end
end
