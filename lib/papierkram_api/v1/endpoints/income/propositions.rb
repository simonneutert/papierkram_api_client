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
            body[:description] = description if description
            body[:time_unit] = time_unit if time_unit
            body[:proposition_type] = proposition_type if proposition_type
            body[:price] = price if price
            body[:vat_rate] = vat_rate if vat_rate

            http_post("#{@url_api_path}/income/propositions", body)
          end

          def update_by(id:, attributes: {})
            if attributes[:vat_rate] && (attributes[:vat_rate].empty? || !attributes[:vat_rate].include?('%'))
              raise ArgumentError, 'vat_rate must be a percentage and include a % sign'
            end

            http_put("#{@url_api_path}/income/propositions/#{id}", attributes)
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
