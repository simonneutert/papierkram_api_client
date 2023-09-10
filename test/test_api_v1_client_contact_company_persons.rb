# frozen_string_literal: true

require 'test_helper'

class TestContactCompany < Minitest::Test
  describe 'Contact::CompanyPersons Requests' do
    it 'get a contact company person', :vcr do
      client = PapierkramApi::Client.new('simonneutert')
      response = client.contact_companies_persons.find_by(company_id: 3, id: 3)
      response_body = response.body

      assert_equal(200, response.status)
      refute_empty(response_body)
    end

    it 'get all contact companies persons paginated', :vcr do
      client = PapierkramApi::Client.new('simonneutert')
      response = client.contact_companies_persons.all(company_id: 3)
      response_body = response.body

      assert_equal(200, response.status)
      refute_empty(response_body)
    end

    it 'create a contact company person', :vcr do
      client = PapierkramApi::Client.new('simonneutert')
      response = client.contact_companies_persons.create(
        company_id: 3,
        first_name: 'Max',
        last_name: 'Mustermann'
      )

      assert_equal(201, response.status)

      assert_equal %w[
        type
        id
        first_name
        last_name
        title
        salutation
        position
        department
        phone
        skype
        fax
        email
        flagged
        created_at
        updated_at
        mobile
        comment
        default
        company
      ].sort, response.body.keys.sort
      assert_equal('Max', response.body['first_name'])
    end

    it 'update a contact company person', :vcr do
      client = PapierkramApi::Client.new('simonneutert')
      response = client.contact_companies_persons.update_by(
        company_id: 3,
        id: 3,
        attributes: {
          last_name: 'Musterwoman'
        }
      )

      assert_equal(200, response.status)

      assert_equal %w[
        comment
        company
        created_at
        default
        department
        email
        fax
        first_name
        flagged
        id
        last_name
        mobile
        phone
        position
        salutation
        skype
        title
        type
        updated_at
      ].sort, response.body.keys.sort
    end

    it 'delete a contact company person', :vcr do
      client = PapierkramApi::Client.new('simonneutert')
      response = client.contact_companies_persons.delete_by(company_id: 3, id: 3)

      assert_equal(204, response.status)
    end
  end
end
