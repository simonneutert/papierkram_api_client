# frozen_string_literal: true

require 'test_helper'

class TestRemainingQuota < Minitest::Test
  describe 'Remaining Quota Header Info' do
    it 'reads remaining quota', :vcr do
      client = PapierkramApi::Client.new('simonneutert')
      response = client.info.details
      # response_body = response.body
      response_headers = response.headers

      assert_equal(200, response.status)
      assert(response_headers.key?('x-remaining-quota'))
      assert_kind_of(String, response_headers['x-remaining-quota'])
      assert_match(/\d+/, response_headers['x-remaining-quota'])
      assert_predicate(response_headers['x-remaining-quota'].to_i, :positive?)
      assert_kind_of(Integer, client.info.remaining_quota(response))
      assert_kind_of(Integer, client.info.remaining_quota(response.headers))
    end
  end
end
