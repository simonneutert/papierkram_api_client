# frozen_string_literal: true

module PapierkramApi
  module V1
    module Endpoints
      module Expense
        # This class is responsible for all the API calls related to expense vouchers.
        class Vouchers < PapierkramApi::V1::Endpoints::Base
          def by(id:, pdf: false)
            if pdf == true
              return get("#{@url_api_path}/expense/vouchers/#{id}/pdf", nil,
                         { headers: { 'Content-Type' => 'application/pdf' } })
            end
            get("#{@url_api_path}/expense/vouchers/#{id}")
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

            get("#{@url_api_path}/expense/vouchers", query)
          end
        end
      end
    end
  end
end
