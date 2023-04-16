# frozen_string_literal: true

module PapierkramApi
  module V1
    module Endpoints
      module Contact
        # This class is responsible for all the API calls related to companies' persons connections.
        class CompaniesPersons < PapierkramApi::V1::Endpoints::Base
          def by(company_id:, id:)
            get("#{@url_api_path}/contact/companies/#{company_id}/persons/#{id}")
          end

          def all(company_id:, page: 1, page_size: 100, order_by: nil, order_direction: nil)
            query = {
              company_id: company_id,
              page: page,
              page_size: page_size
            }
            query[:order_by] = order_by if order_by
            query[:order_direction] = order_direction if order_direction

            get("#{@url_api_path}/contact/companies/#{company_id}/persons", query)
          end
        end
      end
    end
  end
end
