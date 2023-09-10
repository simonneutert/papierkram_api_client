# frozen_string_literal: true

require 'test_helper'

class TestIncomeEstimates < Minitest::Test
  describe 'Income::Estimate Requests' do
    it 'downloads a pdf', :vcr do
      client = PapierkramApi::Client.new('simonneutert')
      response = client.income_estimates.find_by(id: 1, pdf: true)

      assert_equal(200, response.status)
      assert_equal('application/pdf', response.headers['content-type'])
      assert response.body.is_a?(String)
      assert_predicate response.body.length, :positive?
      assert response.body.start_with?('%PDF-1.4')
    end

    it 'get all income estimates paginated', :vcr do
      client = PapierkramApi::Client.new('simonneutert')
      response = client.income_estimates.all
      response_body = response.body

      assert_equal 200, response.status
      assert_equal %w[entries has_more page page_size total_entries total_pages type].sort,
                   response_body.keys.sort
      assert_equal 1, response_body['page']
      assert_equal 100, response_body['page_size']
      assert_equal 1, response_body['total_pages']
      assert_equal 1, response_body['total_entries']
      assert response_body['has_more'].is_a?(FalseClass)
      assert_equal 'list', response_body['type']
      assert response_body['entries'].is_a?(Array)
      assert_equal 1, response_body['entries'].length

      first_entry = response_body['entries'].first

      assert_equal %w[billing
                      custom_template
                      customer_no
                      description
                      document_date
                      estimate_no
                      id
                      name
                      record_state
                      sent_on
                      sent_to
                      sent_via
                      state
                      total_gross
                      total_net
                      total_vat
                      type].sort,
                   first_entry.keys.sort

      assert_equal 'estimate', first_entry['type']
      assert_equal '2020-01-29', first_entry['document_date']
      assert_nil first_entry['due_date']
      assert_nil first_entry['supply_date']
      assert first_entry['name'].is_a?(String)
      assert_equal 'K-00001', first_entry['customer_no']
      assert_in_delta(26.74, first_entry['total_net'])
      assert_in_delta(5.08, first_entry['total_vat'])
      assert_in_delta(31.82, first_entry['total_gross'])

      billing = first_entry['billing']

      assert_equal %w[city
                      company
                      contact_person
                      country
                      department
                      email
                      street
                      ust_idnr
                      zip].sort, billing.keys.sort
      assert billing.is_a?(Hash)
      assert billing['company'].is_a?(String)
      assert billing['email'].is_a?(String) || billing['email'].nil?
      assert billing['ust_idnr'].is_a?(String) || billing['ust_idnr'].nil?
      assert billing['street'].is_a?(String) || billing['street'].nil?
      assert billing['zip'].is_a?(String) || billing['zip'].nil?
      assert billing['city'].is_a?(String) || billing['city'].nil?
      assert billing['country'].is_a?(String) || billing['country'].nil?
      assert billing['contact_person'].is_a?(String) || billing['contact_person'].nil?
      assert billing['department'].is_a?(String) || billing['department'].nil?
    end
  end
end
