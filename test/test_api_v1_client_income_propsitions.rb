# frozen_string_literal: true

require 'test_helper'

class TestIncomePropositions < Minitest::Test
  describe 'Income::Propositions Requests' do
    it 'gets a single income proposition', :vcr do
      client = PapierkramApi::Client.new('simonneutert')
      response = client.income_propositions.find_by(id: 2)
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
        article_no: '12345',
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
      client = PapierkramApi::Client.new('simonneutert')
      response = client.income_propositions.update_by(
        id: 6,
        attributes: {
          article_no: '123456'
        }
      )

      assert_equal(200, response.status)
    end

    it 'archives an income proposition', :vcr do
      client = PapierkramApi::Client.new('simonneutert')
      response = client.income_propositions.archive_by(id: 3)

      assert_equal(200, response.status)
    end

    it 'unarchives an income proposition', :vcr do
      client = PapierkramApi::Client.new('simonneutert')
      response = client.income_propositions.unarchive_by(id: 3)

      assert_equal(200, response.status)
    end

    it 'deletes an income proposition', :vcr do
      client = PapierkramApi::Client.new('simonneutert')
      response = client.income_propositions.delete_by(id: 3)

      assert_equal(204, response.status)
    end
  end
end
