# frozen_string_literal: true

require 'test_helper'

class TestIncomePropositions < Minitest::Test
  describe 'Income::Propositions Requests' do
    it 'gets a single income proposition', :vcr do
      client = PapierkramApi::Client.new('simonneutert')
      response = client.income_propositions.by(id: 2)
      response_body = response.body

      assert_equal(200, response.status)
      refute_empty(response_body)
    end

    it 'gets all income propositions', :vcr do
      client = PapierkramApi::Client.new('simonneutert')
      response = client.income_propositions.all
      response_body = response.body

      assert_equal(200, response.status)
      refute_empty(response_body)
    end

    it 'creates an income proposition', :vcr do
      # TODO: this test fails because of a bug in the API
      client = PapierkramApi::Client.new('simonneutert')
      response = client.income_propositions.create(
        name: 'Software design',
        description: 'Here, we can describe what "Software design" actually entails.',
        time_unit: 'hour',
        proposition_type: 'service',
        price: '150.0',
        vat_rate: '19%'
      )
      response_body = response.body

      assert_equal(201, response.status)
      refute_empty(response_body)
    end

    it 'updates an income proposition', :vcr do
      # TODO: this test fails because of a bug in the API
    end
  end
end
