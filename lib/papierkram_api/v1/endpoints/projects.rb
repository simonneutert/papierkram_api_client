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

        def create( # rubocop:disable Metrics/ParameterLists, Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
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
          default_proposition: nil,
          team_members: nil
        )

          body = {}
          body[:name] = name
          body[:customer] = { id: customer_id }
          body[:description] = description if description
          body[:start_date] = start_date if start_date
          body[:end_date] = end_date if end_date
          body[:flagged] = flagged if flagged
          body[:budget_type] = budget_type if budget_type
          body[:budget_money] = budget_money if budget_money
          body[:budget_time] = budget_time if budget_time
          body[:budget_time_unit] = budget_time_unit if budget_time_unit
          body[:color] = color if color
          body[:default_proposition] = default_proposition if default_proposition
          body[:team_members] = team_members if team_members

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
