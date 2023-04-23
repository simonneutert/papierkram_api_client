# frozen_string_literal: true

require 'test_helper'

class TestBankingBankConnections < Minitest::Test
  describe 'Banking Bank Connections Requests' do
    it 'get a banking bank connections', :vcr do
      client = PapierkramApi::Client.new
      response = client.banking_bank_connections.by(id: 4)
      response_body = response.body

      assert_equal 200, response.status

      assert_equal %w[type
                      id
                      name
                      account_no
                      account_type
                      bic
                      blz
                      connection_type
                      created_at
                      customer_id
                      hbci
                      hbci_host_url
                      hbci_version
                      primary
                      title
                      updated_at
                      user_id
                      iban].sort, response_body.keys.sort

      assert response_body['type'].is_a?(String)
      assert_equal 'bank_connection', response_body['type']
      assert response_body['id'].is_a?(Integer)
      assert_equal 4, response_body['id']
      assert response_body['name'].is_a?(String)
      assert_equal 'Standard', response_body['name']
      assert response_body['account_no'].is_a?(String) || response_body['account_no'].nil?
      assert response_body['account_type'].is_a?(String) || response_body['account_type'].nil?
      assert_equal('default', response_body['account_type'])

      assert response_body['bic'].is_a?(String) || response_body['bic'].nil?
      assert response_body['blz'].is_a?(String) || response_body['blz'].nil?
      assert response_body['connection_type'].is_a?(String) || response_body['connection_type'].nil?
      assert response_body['created_at'].is_a?(String)
      assert response_body['customer_id'].is_a?(Integer) || response_body['customer_id'].nil?
      assert response_body['hbci'].is_a?(TrueClass) || response_body['hbci'].nil?
      assert response_body['hbci_host_url'].is_a?(String) || response_body['hbci_host_url'].nil?
      assert response_body['hbci_version'].is_a?(String) || response_body['hbci_version'].nil?
      assert response_body['primary'].is_a?(TrueClass) || response_body['primary'].nil?
      assert response_body['title'].is_a?(String) || response_body['title'].nil?
      assert response_body['updated_at'].is_a?(String)
      assert response_body['user_id'].is_a?(Integer) || response_body['user_id'].nil?
      assert response_body['iban'].is_a?(String) || response_body['iban'].nil?
    end

    it 'get all banking bank connections paginated', :vcr do
      client = PapierkramApi::Client.new
      response = client.banking_bank_connections.all
      response_body = response.body

      assert_equal 200, response.status

      assert_equal 'list', response_body['type']
      assert response_body['type'].is_a?(String)
      assert_equal 1, response_body['page']
      assert response_body['page'].is_a?(Integer)
      assert_equal 100, response_body['page_size']
      assert response_body['page_size'].is_a?(Integer)
      assert_equal 1, response_body['total_pages']
      assert response_body['total_pages'].is_a?(Integer)
      assert_equal 1, response_body['total_entries']
      refute response_body['has_more']

      assert response_body['entries'].is_a?(Array)
      bank_connection = response_body['entries'].first

      assert bank_connection.is_a?(Hash)
      assert bank_connection['type'].is_a?(String)
      assert_equal 'bank_connection', bank_connection['type']
      assert bank_connection['id'].is_a?(Integer)
      assert_equal 4, bank_connection['id']
      assert bank_connection['name'].is_a?(String)
      assert_equal 'Standard', bank_connection['name']
    end
  end
end
