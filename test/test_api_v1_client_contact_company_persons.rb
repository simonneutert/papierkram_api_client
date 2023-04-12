# frozen_string_literal: true

require 'test_helper'

class TestContactCompany < Minitest::Test
  describe 'Contact Company Persons Requests' do
    it 'get a contact company person', :vcr do
      client = PapierkramApiClient::Client.new('simonneutert')
      response = client.contact_companies_persons.by(company_id: 3, id: 3)
      response_body = response.body

      assert_equal 200, response.status
    end

    it 'get all contact companies persons paginated', :vcr do
      client = PapierkramApiClient::Client.new('simonneutert')
      response = client.contact_companies_persons.all(company_id: 3)
      response_body = response.body

      assert_equal 200, response.status
    end
  end
end
