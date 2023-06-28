# frozen_string_literal: true

module PapierkramApi
  module V1
    module Endpoints
      module Contact
        # This class is responsible for all the API calls related to banking bank connections.
        class Companies < PapierkramApi::V1::Endpoints::Base
          def by(id:)
            get("#{@url_api_path}/contact/companies/#{id}")
          end

          def all(page: 1,
                  page_size: 100,
                  order_by: nil,
                  order_direction: nil)
            query = {
              page: page,
              page_size: page_size
            }
            query[:order_by] = order_by if order_by
            query[:order_direction] = order_direction if order_direction

            get("#{@url_api_path}/contact/companies", query)
          end

          def create_supplier( # rubocop:disable Metrics/ParameterLists
            name:,
            phone: nil,
            fax: nil,
            email: nil,
            delivery_method: nil,
            ust_idnr: nil,
            website: nil,
            twitter: nil,
            postal_street: nil,
            postal_city: nil,
            postal_zip: nil,
            postal_country: nil,
            physical_street: nil,
            physical_city: nil,
            physical_zip: nil,
            physical_country: nil,
            bank_blz: nil,
            bank_institute: nil,
            bank_account_no: nil,
            bank_bic: nil,
            bank_iban: nil,
            notes: nil,
            color: nil
          )

            body = {
              contact_type: :supplier,
              name: name,
              phone: phone,
              fax: fax,
              email: email,
              delivery_method: delivery_method,
              ust_idnr: ust_idnr,
              website: website,
              twitter: twitter,
              postal_street: postal_street,
              postal_city: postal_city,
              postal_zip: postal_zip,
              postal_country: postal_country,
              physical_street: physical_street,
              physical_city: physical_city,
              physical_zip: physical_zip,
              physical_country: physical_country,
              bank_blz: bank_blz,
              bank_institute: bank_institute,
              bank_account_no: bank_account_no,
              bank_bic: bank_bic,
              bank_iban: bank_iban,
              notes: notes,
              color: color
            }

            post("#{@url_api_path}/contact/companies", body)
          end

          def create_customer( # rubocop:disable Metrics/ParameterLists
            name:,
            phone: nil,
            fax: nil,
            email: nil,
            delivery_method: nil,
            ust_idnr: nil,
            website: nil,
            twitter: nil,
            postal_street: nil,
            postal_city: nil,
            postal_zip: nil,
            postal_country: nil,
            physical_street: nil,
            physical_city: nil,
            physical_zip: nil,
            physical_country: nil,
            bank_blz: nil,
            bank_institute: nil,
            bank_account_no: nil,
            bank_bic: nil,
            bank_iban: nil,
            notes: nil,
            color: nil
          )

            body = {
              contact_type: :customer,
              name: name,
              phone: phone,
              fax: fax,
              email: email,
              delivery_method: delivery_method,
              ust_idnr: ust_idnr,
              website: website,
              twitter: twitter,
              postal_street: postal_street,
              postal_city: postal_city,
              postal_zip: postal_zip,
              postal_country: postal_country,
              physical_street: physical_street,
              physical_city: physical_city,
              physical_zip: physical_zip,
              physical_country: physical_country,
              bank_blz: bank_blz,
              bank_institute: bank_institute,
              bank_account_no: bank_account_no,
              bank_bic: bank_bic,
              bank_iban: bank_iban,
              notes: notes,
              color: color
            }

            post("#{@url_api_path}/contact/companies", body)
          end

          def update_by(id:, attributes: {})
            raise ArgumentError, 'id must be an Integer' unless id.is_a?(Integer)
            raise ArgumentError, 'attributes must be a Hash' unless attributes.is_a?(Hash)

            put("#{@url_api_path}/contact/companies/#{id}", attributes)
          end

          def delete_by(id:)
            raise ArgumentError, 'id must be an Integer' unless id.is_a?(Integer)

            delete("#{@url_api_path}/contact/companies/#{id}")
          end

          def archive_by(id:)
            raise ArgumentError, 'id must be an Integer' unless id.is_a?(Integer)

            post("#{@url_api_path}/contact/companies/#{id}/archive")
          end

          def unarchive_by(id:)
            raise ArgumentError, 'id must be an Integer' unless id.is_a?(Integer)

            post("#{@url_api_path}/contact/companies/#{id}/unarchive")
          end
        end
      end
    end
  end
end
