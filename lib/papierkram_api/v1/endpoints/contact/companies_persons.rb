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

          def create( # rubocop:disable Metrics/ParameterLists, Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
            company_id:,
            first_name:,
            last_name:,
            title: nil,
            salutation: nil,
            position: nil,
            department: nil,
            email: nil,
            phone: nil,
            mobile: nil,
            fax: nil,
            skype: nil,
            comment: nil
          )
            body = {}
            body[:first_name] = first_name
            body[:last_name] = last_name
            body[:title] = title if title
            body[:salutation] = salutation if salutation
            body[:position] = position if position
            body[:department] = department if department
            body[:email] = email if email
            body[:phone] = phone if phone
            body[:mobile] = mobile if mobile
            body[:fax] = fax if fax
            body[:skype] = skype if skype
            body[:comment] = comment if comment

            post("#{@url_api_path}/contact/companies/#{company_id}/persons", body)
          end

          def update_by(company_id:, id:, attributes: {})
            raise ArgumentError, 'attributes must be a Hash' unless attributes.is_a?(Hash)
            raise ArgumentError, 'company_id must be an Integer' unless company_id.is_a?(Integer)
            raise ArgumentError, 'id must be an Integer' unless id.is_a?(Integer)

            put("#{@url_api_path}/contact/companies/#{company_id}/persons/#{id}", attributes)
          end

          def delete_by(company_id:, id:)
            raise ArgumentError, 'company_id must be an Integer' unless company_id.is_a?(Integer)
            raise ArgumentError, 'id must be an Integer' unless id.is_a?(Integer)

            delete("#{@url_api_path}/contact/companies/#{company_id}/persons/#{id}")
          end
        end
      end
    end
  end
end
