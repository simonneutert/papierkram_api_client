# frozen_string_literal: true

require 'test_helper'

class TestContactCompany < Minitest::Test
  describe 'Contact::Company Requests' do
    it 'get a contact company', :vcr do
      client = PapierkramApi::Client.new('simonneutert')
      response = client.contact_companies.find_by(id: 3)
      response_body = response.body

      assert_equal 200, response.status

      assert_equal %w[bank_account_no
                      bank_bic
                      bank_blz
                      bank_iban
                      bank_institute
                      bank_sepa_mandate_accepted
                      bank_sepa_mandate_reference
                      color
                      contact_type
                      created_at
                      custom_attributes
                      customer_no
                      delivery_method
                      email
                      fax
                      flagged
                      id
                      inbound_address
                      invoices
                      logo_content_type
                      logo_file_name
                      logo_file_size
                      logo_updated_at
                      name
                      notes
                      people
                      phone
                      physical_city
                      physical_country
                      physical_street
                      physical_zip
                      postal_city
                      postal_country
                      postal_street
                      postal_zip
                      projects
                      record_state
                      supplier_no
                      twitter
                      type
                      updated_at
                      ust_idnr
                      vouchers
                      website].sort, response_body.keys.sort

      assert(response_body['custom_attributes'].is_a?(Array))

      assert_equal 'company', response_body['type']
      assert response_body['type'].is_a?(String)
      assert_equal 3, response_body['id']
      assert response_body['id'].is_a?(Integer)
      assert_equal 'adsad asd', response_body['name']
      assert response_body['name'].is_a?(String)
      assert_equal 'customer', response_body['contact_type']

      assert response_body['people'].is_a?(Hash)
      assert_equal 'list', response_body['people']['type']
      assert_equal '/api/v1/contact/companies/3/persons', response_body['people']['url']

      people_entries = response_body['people']['entries']

      assert people_entries.is_a?(Array)
    end

    it 'get all contact companies paginated', :vcr do
      client = PapierkramApi::Client.new('simonneutert')
      response = client.contact_companies.all
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
      refute_operator response_body, :[], 'has_more'

      assert response_body['entries'].is_a?(Array)
      contact_company = response_body['entries'].first

      assert contact_company.is_a?(Hash)
      assert contact_company['type'].is_a?(String)
      assert_equal 'company', contact_company['type']
      assert contact_company['id'].is_a?(Integer)
      assert_equal 3, contact_company['id']
      assert contact_company['name'].is_a?(String)
      assert_equal 'adsad asd', contact_company['name']
    end

    it 'creates a contact company', :vcr do
      client = PapierkramApi::Client.new('simonneutert')
      response = client.contact_companies.create_customer(
        name: 'adsad asd'
      )
      response_body = response.body

      assert_equal 201, response.status
      assert_equal %w[type
                      id
                      name
                      contact_type
                      supplier_no
                      customer_no
                      email
                      phone
                      website
                      twitter
                      fax
                      postal_street
                      postal_zip
                      postal_city
                      postal_country
                      physical_street
                      physical_zip
                      physical_city
                      physical_country
                      delivery_method
                      ust_idnr
                      logo_file_name
                      logo_content_type
                      logo_file_size
                      logo_updated_at
                      bank_blz
                      bank_institute
                      bank_account_no
                      bank_bic
                      bank_sepa_mandate_reference
                      bank_sepa_mandate_accepted
                      bank_iban
                      inbound_address
                      notes
                      record_state
                      flagged
                      created_at
                      updated_at
                      color
                      people
                      projects
                      invoices
                      vouchers].sort, response_body.keys.sort
    end

    it 'deletes a contact company', :vcr do
      client = PapierkramApi::Client.new('simonneutert')
      response = client.contact_companies.delete_by(id: 6)

      assert_equal 204, response.status
    end

    it 'cannot create a nameless contact company', :vcr do
      client = PapierkramApi::Client.new('simonneutert')
      response = client.contact_companies.create_customer(
        name: '',
        phone: '123456789'
      )
      response_body = response.body

      assert_equal('error', response_body['type'])
      assert_equal('Name muss ausgefüllt werden', response_body['message'])
      assert_equal('unprocessable_entity', response_body['error_type'])
      assert response_body.key?('correlation_id')
      assert_equal 422, response.status
    end

    it 'updates a contact company', :vcr do
      client = PapierkramApi::Client.new('simonneutert')
      response = client.contact_companies.update_by(id: 3, phone: '123456789')

      assert_equal 200, response.status
    end

    it 'cannot delete contact company without matching ID', :vcr do
      client = PapierkramApi::Client.new('simonneutert')
      response = client.contact_companies.delete_by(id: 123_456_789)

      assert_equal 404, response.status
      response_body = response.body

      assert_equal('error', response_body['type'])
      assert_equal("Couldn't find Contact::Company with 'id'=123456789", response_body['message'])
      assert_equal('not_found', response_body['error_type'])
      assert response_body.key?('correlation_id')
    end

    it 'archives and unarchives a contact company', :vcr do
      client = PapierkramApi::Client.new('simonneutert')
      response = client.contact_companies.archive_by(id: 3)

      assert_equal 200, response.status

      response = client.contact_companies.unarchive_by(id: 3)

      assert_equal 200, response.status
    end
  end
end
