# frozen_string_literal: true

require 'test_helper'

class TestBankingTransactions < Minitest::Test
  describe 'Banking::Transaction Requests' do
    it 'get a banking transaction', :vcr do
      client = PapierkramApi::Client.new('simonneutert')
      response = client.banking_transactions.find_by(id: 4)
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

      assert_kind_of(String, response_body['type'])
      assert_equal('banking_transaction', response_body['type'])
      assert_kind_of(Integer, response_body['id'])
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
      assert_kind_of(String, response_body['type'])
      assert_equal(1, response_body['page'])
      assert_kind_of(Integer, response_body['page'])
      assert_equal(2, response_body['page_size'])
      assert_kind_of(Integer, response_body['page_size'])
      assert_equal(5, response_body['total_pages'])
      assert_kind_of(Integer, response_body['total_pages'])
      assert_equal(9, response_body['total_entries'])
      assert_operator(response_body, :[], 'has_more')

      assert_kind_of(Array, response_body['entries'])
      bank_connection = response_body['entries'].first

      assert_kind_of(Hash, bank_connection)
      assert_kind_of(String, bank_connection['type'])
      assert_equal('banking_transaction', bank_connection['type'])
      assert_kind_of(Integer, bank_connection['id'])
      assert_equal(145, bank_connection['id'])
      assert_kind_of(String, bank_connection['state'])
      assert_equal('cleared', bank_connection['state'])
      assert_kind_of(String, bank_connection['currency'])
      assert_equal('EUR', bank_connection['currency'])
      assert(bank_connection['storno'].is_a?(FalseClass) || bank_connection['storno'].nil?)
      assert_nil(bank_connection['storno'])
      assert_kind_of(String, bank_connection['transaction_type'])
    end
  end
end
