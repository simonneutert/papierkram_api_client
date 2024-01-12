# frozen_string_literal: true

module PapierkramApi
  module V1
    module Endpoints
      module Income
        # This class is responsible for all the API calls related to income propositions.
        class Propositions < PapierkramApi::V1::Endpoints::Base
          def find_by(id:)
            http_get("#{@url_api_path}/income/propositions/#{id}")
          end

          def all
            http_get("#{@url_api_path}/income/propositions")
          end

          def create(
            name:,
            article_no:,
            description: nil,
            time_unit: nil,
            proposition_type: nil,
            price: nil,
            vat_rate: nil
          )

            body = {}
            body[:name] = name
            body[:article_no] = article_no

            body[:proposition_type] = proposition_type if proposition_type
            body[:description] = description if description
            body[:time_unit] = time_unit if time_unit
            body[:vat_rate] = vat_rate if vat_rate
            body[:price] = price if price

            http_post("#{@url_api_path}/income/propositions", body)
          end

          def update_by( # rubocop:disable Metrics/CyclomaticComplexity
            id:,
            name: nil,
            description: nil,
            article_no: nil,
            price: nil,
            proposition_type: nil,
            time_unit: nil,
            vat_rate: nil
          )

            body = {}
            body[:name] = name if name
            body[:description] = description if description
            body[:article_no] = article_no if article_no
            body[:price] = price if price
            body[:proposition_type] = proposition_type if proposition_type
            body[:time_unit] = time_unit if time_unit
            body[:vat_rate] = vat_rate if vat_rate

            http_put("#{@url_api_path}/income/propositions/#{id}", body)
          end

          def delete_by(id:)
            http_delete("#{@url_api_path}/income/propositions/#{id}")
          end

          def archive_by(id:)
            http_post("#{@url_api_path}/income/propositions/#{id}/archive")
          end

          def unarchive_by(id:)
            http_post("#{@url_api_path}/income/propositions/#{id}/unarchive")
          end
        end
      end
    end
  end
end
