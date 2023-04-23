# frozen_string_literal: true

require 'test_helper'

class TestIncomePropositions < Minitest::Test
  describe 'Income Propositions Requests' do
    it 'gets a single income proposition', :vcr do
      client = PapierkramApi::Client.new
      response = client.income_propositions.by(id: 2)
      response_body = response.body

      assert_equal(200, response.status)
      refute_empty(response_body)
    end

    it 'gets all income propositions', :vcr do
      client = PapierkramApi::Client.new
      response = client.income_propositions.all
      response_body = response.body

      assert_equal(200, response.status)
      refute_empty(response_body)
    end
  end
end
