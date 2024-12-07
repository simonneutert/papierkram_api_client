# frozen_string_literal: true

module PapierkramApi
  module V1
    module Endpoints
      module Income
        # This class is responsible for all the API calls related to income invoices.
        class Invoices < PapierkramApi::V1::Endpoints::Base
          ALLOWED_SEND_VIA = %i[email pdf].freeze

          def find_by(id:, pdf: false)
            if pdf == true
              return http_get(
                "#{@url_api_path}/income/invoices/#{id}/pdf",
                nil,
                { headers: { 'Content-Type' => 'application/pdf' } }
              )
            end

            http_get("#{@url_api_path}/income/invoices/#{id}")
          end

          def all( # rubocop:disable Metrics/CyclomaticComplexity
            page: 1,
            page_size: 100,
            order_by: nil,
            order_direction: nil,
            creditor_id: nil,
            project_id: nil,
            document_date_range_start: nil,
            document_date_range_end: nil
          )
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

            http_get("#{@url_api_path}/income/invoices", query)
          end

          def create( # rubocop:disable Metrics/ParameterLists,Metrics/AbcSize,Metrics/CyclomaticComplexity,Metrics/MethodLength,Metrics/PerceivedComplexity
            name:,
            line_items:,
            payment_term_id:,
            description: nil,
            flagged: nil,
            document_date: nil,
            supply_date: nil,
            customer_id: nil,
            contact_person_id: nil,
            project_id: nil,
            custom_template_id: nil,
            billing_company: nil,
            billing_department: nil,
            billing_contact_person: nil,
            billing_street: nil,
            billing_zip: nil,
            billing_city: nil,
            billing_country: nil,
            billing_ust_idnr: nil,
            billing_email: nil
          )
            body = {}
            body[:name] = name
            body[:line_items] = line_items
            body[:payment_term] = { id: payment_term_id }
            body[:description] = description if description
            body[:flagged] = flagged if flagged
            body[:document_date] = document_date if document_date
            body[:supply_date] = supply_date if supply_date
            body[:customer] = { id: customer_id } if customer_id
            body[:customer][:contact_person] = { id: contact_person_id } if contact_person_id
            body[:customer][:project] = { id: project_id } if project_id
            body[:custom_template] = { id: custom_template_id } if custom_template_id

            body[:billing] = {}
            body[:billing][:company] = billing_company if billing_company
            body[:billing][:department] = billing_department if billing_department
            body[:billing][:contact_person] = billing_contact_person if billing_contact_person
            body[:billing][:street] = billing_street if billing_street
            body[:billing][:zip] = billing_zip if billing_zip
            body[:billing][:city] = billing_city if billing_city
            body[:billing][:country] = billing_country if billing_country
            body[:billing][:ust_idnr] = billing_ust_idnr if billing_ust_idnr
            body[:billing][:email] = billing_email if billing_email

            http_post("#{@url_api_path}/income/invoices", body)
          end

          def update_by( # rubocop:disable Metrics/AbcSize,Metrics/CyclomaticComplexity,Metrics/MethodLength,Metrics/PerceivedComplexity,Metrics/ParameterLists
            id:,
            name: nil,
            line_items: nil,
            payment_term_id: nil,
            description: nil,
            flagged: nil,
            document_date: nil,
            supply_date: nil,
            customer_id: nil,
            contact_person_id: nil,
            project_id: nil,
            custom_template_id: nil,
            billing_company: nil,
            billing_department: nil,
            billing_contact_person: nil,
            billing_street: nil,
            billing_zip: nil,
            billing_city: nil,
            billing_country: nil,
            billing_ust_idnr: nil,
            billing_email: nil
          )
            body = {}
            body[:name] = name if name
            body[:line_items] = line_items if line_items
            body[:payment_term] = { id: payment_term_id } if payment_term_id
            body[:description] = description if description
            body[:flagged] = flagged if flagged
            body[:document_date] = document_date if document_date
            body[:supply_date] = supply_date if supply_date
            body[:customer] = { id: customer_id } if customer_id
            body[:customer][:contact_person] = { id: contact_person_id } if contact_person_id
            body[:customer][:project] = { id: project_id } if project_id
            body[:custom_template] = { id: custom_template_id } if custom_template_id

            body[:billing] = {}
            body[:billing][:company] = billing_company if billing_company
            body[:billing][:department] = billing_department if billing_department
            body[:billing][:contact_person] = billing_contact_person if billing_contact_person
            body[:billing][:street] = billing_street if billing_street
            body[:billing][:zip] = billing_zip if billing_zip
            body[:billing][:city] = billing_city if billing_city
            body[:billing][:country] = billing_country if billing_country
            body[:billing][:ust_idnr] = billing_ust_idnr if billing_ust_idnr
            body[:billing][:email] = billing_email if billing_email

            http_put("#{@url_api_path}/income/invoices/#{id}", body)
          end

          def deliver_by( # rubocop:disable Metrics/AbcSize
            id:,
            email_recipient: nil,
            email_subject: nil,
            email_body: nil,
            send_via: :pdf
          )
            raise ArgumentError, 'send_via must be :email or :pdf' unless ALLOWED_SEND_VIA.include?(send_via)

            body = {}
            body[:send_via] = send_via

            if send_via == :email
              if email_recipient.nil? || email_subject.nil? || email_body.nil?
                raise ArgumentError, 'email_recipient, email_subject and email_body must be set'
              end

              body[:email] = {}
              body[:email][:recipient] = email_recipient
              body[:email][:subject] = email_subject
              body[:email][:body] = email_body
            end

            http_post("#{@url_api_path}/income/invoices/#{id}/deliver", body)
          end

          def delete_by(id:)
            http_delete("#{@url_api_path}/income/invoices/#{id}")
          end

          def archive_by(id:)
            http_post("#{@url_api_path}/income/invoices/#{id}/archive")
          end

          def unarchive_by(id:)
            http_post("#{@url_api_path}/income/invoices/#{id}/unarchive")
          end

          def cancel_by(id:)
            http_post("#{@url_api_path}/income/invoices/#{id}/cancel")
          end
        end
      end
    end
  end
end
