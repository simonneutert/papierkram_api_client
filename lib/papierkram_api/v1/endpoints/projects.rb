# frozen_string_literal: true

module PapierkramApi
  module V1
    module Endpoints
      # This class is responsible for all the API calls related to projects connections.
      class Projects < PapierkramApi::V1::Endpoints::Base
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

        def create( # rubocop:disable Metrics/ParameterLists
          name:,
          customer_id:,
          description: nil,
          start_date: nil,
          end_date: nil,
          flagged: nil,
          budget_type: nil,
          budget_money: nil,
          budget_time: nil,
          budget_time_unit: nil,
          color: nil,
          default_proposition: {},
          team_members: []
        )
          body = {
            name: name,
            description: description,
            start_date: start_date,
            end_date: end_date,
            flagged: flagged,
            budget_type: budget_type,
            budget_money: budget_money,
            budget_time: budget_time,
            budget_time_unit: budget_time_unit,
            color: color,
            customer: { id: customer_id },
            default_proposition: default_proposition,
            team_members: team_members
          }

          post("#{@url_api_path}/projects", body)
        end

        def update_by(id:, attributes: {})
          raise ArgumentError, 'attributes must be a Hash' unless attributes.is_a?(Hash)

          put("#{@url_api_path}/projects/#{id}", attributes)
        end

        def delete_by(id:)
          delete("#{@url_api_path}/projects/#{id}")
        end

        def archive_by(id:)
          post("#{@url_api_path}/projects/#{id}/archive")
        end

        def unarchive_by(id:)
          post("#{@url_api_path}/projects/#{id}/unarchive")
        end
      end
    end
  end
end
