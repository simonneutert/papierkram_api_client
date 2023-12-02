# frozen_string_literal: true

module PapierkramApi
  module V1
    module Endpoints
      module Tracker
        # This class is responsible for all the API calls related to tracker time entries connections.
        class TimeEntries < PapierkramApi::V1::Endpoints::Base
          def find_by(id:)
            http_get("#{@url_api_path}/tracker/time_entries/#{id}")
          end

          def all(page: 1, # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/ParameterLists
                  page_size: 100,
                  order_by: nil,
                  order_direction: nil,
                  project_id: nil,
                  task_id: nil,
                  invoice_id: nil,
                  user_id: nil,
                  billing_state: nil,
                  start_time_range_start: nil,
                  start_time_range_end: nil)
            validate!(billing_state: billing_state,
                      start_time_range_start: start_time_range_start,
                      start_time_range_end: start_time_range_end)

            query = {
              page: page,
              page_size: page_size
            }
            query[:order_by] = order_by if order_by
            query[:order_direction] = order_direction if order_direction
            query[:project_id] = project_id if project_id
            query[:task_id] = task_id if task_id
            query[:invoice_id] = invoice_id if invoice_id
            query[:user_id] = user_id if user_id
            query[:billing_state] = billing_state if billing_state
            query[:start_time_range_start] = start_time_range_start if start_time_range_start
            query[:start_time_range_end] = start_time_range_end if start_time_range_end

            http_get("#{@url_api_path}/tracker/time_entries", query)
          end

          def create(
            entry_date:,
            started_at_time:,
            ended_at_time:,
            task_id:,
            user_id:,
            comments: nil,
            billable_duration: nil,
            unbillable: nil
          )
            body = {}
            body[:entry_date] = entry_date
            body[:started_at_time] = started_at_time
            body[:ended_at_time] = ended_at_time
            body[:task] = { id: task_id }
            body[:user] = { id: user_id }
            body[:comments] = comments if comments
            body[:billable_duration] = billable_duration if billable_duration
            body[:unbillable] = unbillable if unbillable

            http_post("#{@url_api_path}/tracker/time_entries", body)
          end

          def update_by( # rubocop:disable Metrics/ParameterLists, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
            id:,
            entry_date: nil,
            started_at_time: nil,
            ended_at_time: nil,
            task_id: nil,
            user_id: nil,
            comments: nil,
            billable_duration: nil,
            unbillable: nil
          )
            body = {}
            body[:entry_date] = entry_date if entry_date
            body[:started_at_time] = started_at_time if started_at_time
            body[:ended_at_time] = ended_at_time if ended_at_time
            body[:task] = { id: task_id } if task_id
            body[:user] = { id: user_id } if user_id
            body[:comments] = comments if comments
            body[:billable_duration] = billable_duration if billable_duration
            body[:unbillable] = unbillable if unbillable

            http_put("#{@url_api_path}/tracker/time_entries/#{id}", body)
          end

          def delete_by(id:)
            http_delete("#{@url_api_path}/tracker/time_entries/#{id}")
          end

          def archive_by(id:)
            http_post("#{@url_api_path}/tracker/time_entries/#{id}/archive")
          end

          def unarchive_by(id:)
            http_post("#{@url_api_path}/tracker/time_entries/#{id}/unarchive")
          end

          private

          def validate!(billing_state:, start_time_range_start:, start_time_range_end:)
            if billing_state && !%w[billed unbilled billable unbillable archived].include?(billing_state)
              raise ArgumentError,
                    'billing_state must be one of: "billed" "unbilled"" billable" "unbillable" "archived"'
            end
            if start_time_range_start && !start_time_range_start.is_a?(Time)
              raise ArgumentError, 'start_time_range_start must be a Time object'
            end
            return unless start_time_range_end && !start_time_range_end.is_a?(Time)

            raise ArgumentError, 'start_time_range_end must be a Time object'
          end
        end
      end
    end
  end
end
