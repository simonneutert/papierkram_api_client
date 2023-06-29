# frozen_string_literal: true

module PapierkramApi
  module V1
    module Endpoints
      module Income
        # This class is responsible for all the API calls related to income propositions.
        class Propositions < PapierkramApi::V1::Endpoints::Base
          def by(id:)
            get("#{@url_api_path}/income/propositions/#{id}")
          end

          def all
            get("#{@url_api_path}/income/propositions")
          end

          def create(
            name:,
            article_no:,
            description: nil,
            time_unit: nil,
            proposition_type: nil,
            price: nil,
            vat_rate: ''
          )
            body = {
              name: name,
              article_no: article_no,
              description: description,
              time_unit: time_unit,
              proposition_type: proposition_type,
              price: price,
              vat_rate: vat_rate
            }
            post("#{@url_api_path}/income/propositions", body)
          end

          def update_by(id:, attributes: {})
            attributes[:vat_rate] ||= attributes['vat_rate']
            attributes[:vat_rate] ||= ''
            if attributes[:vat_rate].empty? || (!attributes[:vat_rate].to_s.empty? && !attributes[:vat_rate].include?('%'))
              raise ArgumentError, 'vat_rate must be a percentage and include a % sign'
            end

            put("#{@url_api_path}/income/propositions/#{id}", attributes)
          end

          def delete_by(id:)
            delete("#{@url_api_path}/income/propositions/#{id}")
          end

          def archive_by(id:)
            post("#{@url_api_path}/income/propositions/#{id}/archive")
          end

          def unarchive_by(id:)
            post("#{@url_api_path}/income/propositions/#{id}/unarchive")
          end
        end
      end
    end
  end
end
