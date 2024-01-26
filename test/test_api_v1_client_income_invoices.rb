# frozen_string_literal: true

require 'test_helper'

class TestIncomeInvoices < Minitest::Test
  describe 'Income::Invoices Constants' do
    it 'ALLOWED_SEND_VIA is an array' do
      assert_kind_of(Array, PapierkramApi::V1::Endpoints::Income::Invoices::ALLOWED_SEND_VIA)
      assert_equal(%i[email pdf], PapierkramApi::V1::Endpoints::Income::Invoices::ALLOWED_SEND_VIA)
    end
  end

  describe 'Income::Invoice Requests' do
    it 'downloads a pdf', :vcr do
      client = PapierkramApi::Client.new('simonneutert')
      response = client.income_invoices.find_by(id: 35, pdf: true)

      assert_equal(200, response.status)
      assert_equal('application/pdf', response.headers['content-type'])
      assert_kind_of(String, response.body)
      assert_predicate(response.body.length, :positive?)
      assert(response.body.start_with?('%PDF-1.4'))
    end

    it 'get all income invoices paginated', :vcr do
      client = PapierkramApi::Client.new('simonneutert')
      response = client.income_invoices.all
      response_body = response.body

      assert_equal(200, response.status)
      assert_equal(%w[entries
                      has_more
                      page
                      page_size
                      total_entries
                      total_pages
                      type].sort, response_body.keys.sort)
      assert_equal(1, response_body['page'])
      assert_equal(100, response_body['page_size'])
      assert_equal(1, response_body['total_pages'])
      assert_equal(3, response_body['total_entries'])
      assert_kind_of(FalseClass, response_body['has_more'])
      assert_equal('list', response_body['type'])
      assert_kind_of(Array, response_body['entries'])
      assert_equal(3, response_body['entries'].length)

      first_entry = response_body['entries'].first

      assert_equal(%w[billing
                      custom_template
                      customer_no
                      description
                      document_date
                      down_payment_total_gross
                      due_date
                      id
                      invoice_no
                      name
                      outstanding_amount
                      paid_at_date
                      record_state
                      sent_on
                      sent_to
                      sent_via
                      state
                      supply_date
                      total_gross
                      total_net
                      total_vat
                      type
                      type_of].sort,
                   first_entry.keys.sort)

      assert_equal('invoice', first_entry['type'])
      assert_equal('2018-11-30', first_entry['document_date'])
      assert_equal('2018-12-14', first_entry['due_date'])
      assert_equal('30.11.2018', first_entry['supply_date'])
      assert(first_entry['name'].nil? || first_entry['name'].is_a?(String))
      assert_equal('K-00001', first_entry['customer_no'])
      assert_equal('R-00001', first_entry['invoice_no'])
      assert_in_delta(13.37, first_entry['total_net'])
      assert_in_delta(15.91, first_entry['total_gross'])
      assert_in_delta(2.54, first_entry['total_vat'])

      billing = first_entry['billing']

      assert_equal(
        %w[city
           company
           contact_person
           country
           department
           email
           street
           ust_idnr
           zip].sort,
        billing.keys.sort
      )
      assert_kind_of(Hash, billing)
      assert_kind_of(String, billing['company'])
      assert(billing['email'].is_a?(String) || billing['email'].nil?)
      assert(billing['ust_idnr'].is_a?(String) || billing['ust_idnr'].nil?)
      assert(billing['street'].is_a?(String) || billing['street'].nil?)
      assert(billing['zip'].is_a?(String) || billing['zip'].nil?)
      assert(billing['city'].is_a?(String) || billing['city'].nil?)
      assert(billing['country'].is_a?(String) || billing['country'].nil?)
      assert(billing['contact_person'].is_a?(String) || billing['contact_person'].nil?)
      assert(billing['department'].is_a?(String) || billing['department'].nil?)
    end

    it 'creates an income invoice', :vcr do
      client = PapierkramApi::Client.new('simonneutert')
      response = client.income_invoices.create(
        name: 'Neuausstattung des Büros',
        supply_date: '01.01.2024 - 14.01.2024',
        document_date: '2024-01-15',
        payment_term_id: 46,
        customer_id: 3,
        project_id: 15,
        line_items: [
          {
            name: 'Anlieferung',
            description: 'Anlieferung der neuen Möbel',
            quantity: 1.25,
            unit: 'Stunden',
            vat_rate: '19%',
            price: 100
          },
          {
            name: 'Bestuhlung',
            description: 'Bestuhlung des Bürogebäudes',
            quantity: 1.25,
            unit: 'Arbeitstage',
            vat_rate: '19%',
            price: 800
          },
          {
            name: 'Büroartikel',
            description: 'Neue Bürostühle',
            quantity: 200,
            unit: 'Stühle',
            vat_rate: '19%',
            price: 125
          }
        ]
      )

      response_body = response.body

      assert_equal(201, response.status)
      assert_kind_of(Integer, response_body['id'])
    end

    it 'updates an income invoice', :vcr do
      client = PapierkramApi::Client.new('simonneutert')
      response = client.income_invoices.update_by(
        id: 9,
        name: 'Neuausstattung eines Büros',
        line_items: [
          {
            name: 'Anlieferung',
            description: 'Anlieferung der neuen Möbel',
            quantity: 1.5,
            unit: 'Stunden',
            vat_rate: '19%',
            price: 100
          },
          {
            name: 'Bestuhlung',
            description: 'Bestuhlung des Bürogebäudes',
            quantity: 1.5,
            unit: 'Arbeitstage',
            vat_rate: '19%',
            price: 800
          },
          {
            name: 'Büroartikel',
            description: 'Neue Bürostühle',
            quantity: 200,
            unit: 'Stühle',
            vat_rate: '19%',
            price: 125
          }
        ]
      )

      response_body = response.body

      assert_equal(200, response.status)
      assert_equal(9, response_body['id'])
    end

    it 'deletes an income invoice', :vcr do
      client = PapierkramApi::Client.new('simonneutert')
      response = client.income_invoices.delete_by(id: 9)

      assert_equal(204, response.status)
    end

    it 'archives an income invoice', :vcr do
      client = PapierkramApi::Client.new('simonneutert')
      response = client.income_invoices.archive_by(id: 12)

      assert_equal(200, response.status)
    end

    it 'unarchives an income invoice', :vcr do
      client = PapierkramApi::Client.new('simonneutert')
      response = client.income_invoices.unarchive_by(id: 12)

      assert_equal(200, response.status)
    end

    it 'cancels an income invoice', :vcr do
      client = PapierkramApi::Client.new('simonneutert')
      response = client.income_invoices.cancel_by(id: 12)

      assert_equal(200, response.status)
    end

    it 'delivers an income invoice via pdf', :vcr do
      client = PapierkramApi::Client.new('simonneutert')
      response = client.income_invoices.deliver_by(
        id: 6,
        send_via: :pdf
      )

      assert_equal(204, response.status)
    end
  end
end
