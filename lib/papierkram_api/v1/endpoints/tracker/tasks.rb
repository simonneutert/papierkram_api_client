# frozen_string_literal: true

module PapierkramApi
  module V1
    module Endpoints
      module Tracker
        # This class is responsible for all the API calls related to tracker tasks connections.
        class Tasks < PapierkramApi::V1::Endpoints::Base
          def find_by(id:)
            http_get("#{@url_api_path}/tracker/tasks/#{id}")
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
            http_get("#{@url_api_path}/tracker/tasks", query)
          end

          def create(
            name:,
            project_id:,
            proposition_id: nil,
            deadline: nil,
            relative_costs: nil,
            complete: nil,
            flagged: nil,
            user_id: nil
          )
            body = {}
            body[:name] = name
            body[:project] = { id: project_id }
            body[:proposition] = { id: proposition_id } if proposition_id
            body[:deadline] = deadline if deadline
            body[:relative_costs] = relative_costs if relative_costs
            body[:complete] = complete if complete
            body[:flagged] = flagged if flagged
            body[:user] = { id: user_id } if user_id

            http_post("#{@url_api_path}/tracker/tasks", body)
          end

          def update_by( # rubocop:disable Metrics/ParameterLists
            id:,
            name:,
            project_id:,
            proposition_id: nil,
            deadline: nil,
            relative_costs: nil,
            complete: nil,
            flagged: nil,
            user_id: nil
          )
            body = {}
            body[:name] = name
            body[:project] = { id: project_id }
            body[:proposition] = { id: proposition_id } if proposition_id
            body[:deadline] = deadline if deadline
            body[:relative_costs] = relative_costs if relative_costs
            body[:complete] = complete if complete
            body[:flagged] = flagged if flagged
            body[:user] = { id: user_id } if user_id

            http_put("#{@url_api_path}/tracker/tasks/#{id}", body)
          end

          def delete_by(id:)
            http_delete("#{@url_api_path}/tracker/tasks/#{id}")
          end

          def archive_by(id:)
            raise ArgumentError, 'id must be an Integer' unless id.is_a?(Integer)

            http_post("#{@url_api_path}/tracker/tasks/#{id}/archive")
          end

          def unarchive_by(id:)
            raise ArgumentError, 'id must be an Integer' unless id.is_a?(Integer)

            http_post("#{@url_api_path}/tracker/tasks/#{id}/unarchive")
          end
        end
      end
    end
  end
end
