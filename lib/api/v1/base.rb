# frozen_string_literal: true

module Api
  module V1
    # This class is the base class for all the API calls.
    class Base
      attr_reader :client, :url_api_path

      def initialize(client)
        @client = client
        @url_api_path = '/api/v1'
      end

      def remaining_quota(response)
        return response.headers['x-remaining-quota'].to_i if response.is_a?(Faraday::Response)
        raise ArgumentError, 'Invalid response object' unless response.is_a?(Hash)

        quota = response.dig('headers', 'x-remaining-quota') || response['x-remaining-quota']
        return Integer(quota) if quota

        raise ArgumentError, "No remaining quota found in response: #{response}"
      end

      def get(url, params = {}, headers = {})
        validate_get!(params)
        call_wrapper!(:get, url, params, headers)
      end

      def post(url, params = {}, headers = {})
        call_wrapper!(:post, url, params, headers)
      end

      def put(url, params = {}, headers = {})
        call_wrapper!(:put, url, params, headers)
      end

      def patch(url, params = {}, headers = {})
        call_wrapper!(:patch, url, params, headers)
      end

      def delete(url, params = {}, headers = {})
        call_wrapper!(:delete, url, params, headers)
      end

      private

      def call_wrapper!(method, url, params = {}, headers = {})
        @client.send(method, url, params, headers)
      end

      def validate_order_direction!(order_direction)
        return if order_direction.nil?

        raise ArgumentError, 'Invalid order direction' unless %w[asc desc].include?(order_direction)
      end

      def validate_billing_state!(billing_state)
        return if billing_state.nil?

        raise ArgumentError, 'Invalid billing state' unless %w[billed
                                                               unbilled
                                                               billable
                                                               unbillable
                                                               archived].include?(billing_state)
      end

      def validate_get!(params)
        return unless params

        validate_order_direction!(params[:order_direction])
        validate_billing_state!(params[:billing_state])
      end
    end
  end
end
