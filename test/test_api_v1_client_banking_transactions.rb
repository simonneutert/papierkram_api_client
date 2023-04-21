# frozen_string_literal: true

require 'test_helper'

class TestBankingTransactions < Minitest::Test
  describe 'Banking Transaction Requests' do
    it 'get a banking transaction', :vcr do
      client = PapierkramApi::Client.new('simonneutert')
      response = client.banking_transactions.by(id: 4)
      response_body = response.body

      assert_equal(200, response.status)

      assert_equal(%w[bank_connection
                      bdate
                      categories
                      created_at
                      currency
                      customerref
                      fintecapi_turnover_id
                      from
                      gvcode
                      id
                      imported_at
                      instref
                      primanota
                      saldo
                      seen
                      sepa
                      state
                      storno
                      tags
                      text
                      transaction_type
                      type
                      updated_at
                      usage
                      value
                      valuta].sort,
                   response_body.keys.sort)

      assert(response_body['type'].is_a?(String))
      assert_equal('banking_transaction', response_body['type'])
      assert(response_body['id'].is_a?(Integer))
      assert_equal(4, response_body['id'])
    end

    it 'get all banking bank connections paginated', :vcr do
      client = PapierkramApi::Client.new('simonneutert')
      response = client.banking_transactions.all(bank_connection_id: 4,
                                                 page: 1,
                                                 page_size: 2)
      response_body = response.body

      assert_equal(200, response.status)

      assert_equal('list', response_body['type'])
      assert(response_body['type'].is_a?(String))
      assert_equal(1, response_body['page'])
      assert(response_body['page'].is_a?(Integer))
      assert_equal(2, response_body['page_size'])
      assert(response_body['page_size'].is_a?(Integer))
      assert_equal(5, response_body['total_pages'])
      assert(response_body['total_pages'].is_a?(Integer))
      assert_equal(9, response_body['total_entries'])
      assert(response_body['has_more'])

      assert(response_body['entries'].is_a?(Array))
      bank_connection = response_body['entries'].first

      assert(bank_connection.is_a?(Hash))
      assert(bank_connection['type'].is_a?(String))
      assert_equal('banking_transaction', bank_connection['type'])
      assert(bank_connection['id'].is_a?(Integer))
      assert_equal(145, bank_connection['id'])
      assert(bank_connection['state'].is_a?(String))
      assert_equal('cleared', bank_connection['state'])
      assert(bank_connection['value'].is_a?(Float))
      assert_in_delta(-200.0, bank_connection['value'])
      assert(bank_connection['currency'].is_a?(String))
      assert_equal('EUR', bank_connection['currency'])
      assert(bank_connection['storno'].is_a?(FalseClass) || bank_connection['storno'].nil?)
      refute(!bank_connection['storno'].nil?)
      assert(bank_connection['transaction_type'].is_a?(String))
    end
  end
end
