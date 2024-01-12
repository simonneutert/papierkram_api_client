# frozen_string_literal: true

module PapierkramApi
  module V1
    module Endpoints
      module Expense
        # This class is responsible for all the API calls related to expense vouchers.
        class Vouchers < PapierkramApi::V1::Endpoints::Base
          ALLOWED_DIFFERENCE_REASONS = %w[sonstige mahnung teilzahlung skonto sonstige schmaelerung].freeze

          def find_by(id:, pdf: false)
            if pdf == true
              return get("#{@url_api_path}/expense/vouchers/#{id}/pdf", nil,
                         { headers: { 'Content-Type' => 'application/pdf' } })
            end
            http_get("#{@url_api_path}/expense/vouchers/#{id}")
          end

          def all(page: 1, # rubocop:disable Metrics/CyclomaticComplexity
                  page_size: 100,
                  order_by: nil,
                  order_direction: nil,
                  creditor_id: nil,
                  project_id: nil,
                  document_date_range_start: nil,
                  document_date_range_end: nil)
            query = {
              page: page,
              page_size: page_size
            }
            query[:order_by] = order_by if order_by
            query[:order_direction] = order_direction if order_direction
            query[:creditor_id] = creditor_id if creditor_id
            query[:project_id] = project_id if project_id
            query[:document_date_range_start] = document_date_range_start if document_date_range_start
            if document_date_range_end && document_date_range_start
              query[:document_date_range_end] =
                document_date_range_end
            end

            http_get("#{@url_api_path}/expense/vouchers", query)
          end

          def create( # rubocop:disable Metrics/ParameterLists,Metrics/AbcSize,Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity,Metrics/MethodLength
            name:,
            provenance:,
            line_items:,
            due_date: nil,
            document_date: nil,
            description: nil,
            entertainment_reason: nil,
            entertainment_persons: nil,
            flagged: nil,
            creditor_id: nil
          )
            body = {}
            body[:name] = name
            body[:line_items] = line_items
            body[:provenance] = provenance

            body[:due_date] = due_date if due_date
            body[:document_date] = document_date if document_date
            body[:description] = description if description
            body[:entertainment_reason] = entertainment_reason if entertainment_reason
            body[:entertainment_persons] = entertainment_persons if entertainment_persons
            body[:flagged] = flagged if flagged
            body[:creditor] = { id: creditor_id } if creditor_id

            if entertainment_persons
              raise ArgumentError, 'entertainment_persons must be an array' unless entertainment_persons.is_a?(Array)

              unless entertainment_persons.all?(String)
                raise ArgumentError,
                      'entertainment_persons must be an array of strings'
              end
            end

            if line_items
              raise ArgumentError, 'line_items must be an array' unless line_items.is_a?(Array)
              raise ArgumentError, 'line_items must be an array of hashes' unless line_items.all?(Hash)
            end

            http_post("#{@url_api_path}/expense/vouchers", body)
          end

          def update_by( # rubocop:disable Metrics/ParameterLists,Metrics/AbcSize,Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity
            id:,
            name: nil,
            due_date: nil,
            document_date: nil,
            description: nil,
            entertainment_reason: nil,
            entertainment_persons: nil,
            flagged: nil,
            provenance: nil,
            creditor_id: nil,
            line_items: nil
          )
            body = {}
            body[:name] = name if name
            body[:due_date] = due_date if due_date
            body[:document_date] = document_date if document_date
            body[:description] = description if description
            body[:entertainment_reason] = entertainment_reason if entertainment_reason
            body[:entertainment_persons] = entertainment_persons if entertainment_persons
            body[:flagged] = flagged if flagged
            body[:provenance] = provenance if provenance
            body[:creditor] = { id: creditor_id } if creditor_id
            body[:line_items] = line_items if line_items

            if line_items
              raise ArgumentError, 'line_items must be an array' unless line_items.is_a?(Array)
              raise ArgumentError, 'line_items must be an array of hashes' unless line_items.all?(Hash)
            end

            http_put("#{@url_api_path}/expense/vouchers/#{id}", body)
          end

          def add_document_by(id:, path_to_file:, file_type:)
            doc = Faraday::Multipart::FilePart.new(path_to_file, file_type)

            http_post("#{@url_api_path}/expense/vouchers/#{id}/documents", { file: doc })
          end

          def delete_document_by(id:, document_id:)
            http_delete("#{@url_api_path}/expense/vouchers/#{id}/documents/#{document_id}")
          end

          def delete_by(id:)
            http_delete("#{@url_api_path}/expense/vouchers/#{id}")
          end

          def archive_by(id:)
            http_post("#{@url_api_path}/expense/vouchers/#{id}/archive")
          end

          def unarchive_by(id:)
            http_post("#{@url_api_path}/expense/vouchers/#{id}/unarchive")
          end

          def cancel_by(id:)
            http_post("#{@url_api_path}/expense/vouchers/#{id}/cancel")
          end

          def cancel_with_reverse_entry_by(id:)
            http_post("#{@url_api_path}/expense/vouchers/#{id}/cancel_with_reverse_entry")
          end

          def mark_as_paid_by(
            id:,
            value: nil,
            payment_date: nil,
            banking_transaction_id: nil,
            difference_reason: nil
          )
            unless value || banking_transaction_id
              raise ArgumentError, 'either value or banking_transaction_id must be given'
            end

            body = {}

            if value
              validate_value!(value)
              body[:value] = value
            end

            if difference_reason
              validate_difference_reason!(difference_reason)
              body[:difference_reason] = difference_reason
            end

            body[:payment_date] = payment_date if payment_date
            body[:banking_transaction] = { id: banking_transaction_id } if banking_transaction_id

            http_post("#{@url_api_path}/expense/vouchers/#{id}/pay", body)
          end

          private

          def validate_value!(value)
            raise ArgumentError, 'value must be a float' unless value.is_a?(Numeric)
          end

          def validate_difference_reason!(difference_reason)
            raise ArgumentError, 'difference_reason must be a string' unless difference_reason.is_a?(String)

            return if ALLOWED_DIFFERENCE_REASONS.include?(difference_reason)

            raise ArgumentError, "difference_reason must be one of: #{ALLOWED_DIFFERENCE_REASONS.join(', ')}"
          end
        end
      end
    end
  end
end
