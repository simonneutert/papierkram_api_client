# frozen_string_literal: true

require 'test_helper'

class TestExpenseVouchers < Minitest::Test
  describe 'Expense::Vouchers Requests' do
    it 'defines ALLOWED_DIFFERENCE_REASONS' do
      assert_equal(%w[sonstige mahnung teilzahlung skonto sonstige schmaelerung],
                   PapierkramApi::V1::Endpoints::Expense::Vouchers::ALLOWED_DIFFERENCE_REASONS)
    end

    it 'gets a single expense voucher', :vcr do
      client = PapierkramApi::Client.new('simonneutert')
      response = client.expense_vouchers.find_by(id: 650)
      response_body = response.body

      assert_equal(200, response.status)
      refute_empty(response_body)
    end

    it 'gets all expense vouchers', :vcr do
      client = PapierkramApi::Client.new('simonneutert')
      response = client.expense_vouchers.all
      response_body = response.body

      assert_equal(200, response.status)
      refute_empty(response_body)
    end

    it 'gets all expense vouchers ordered by id desc', :vcr do
      client = PapierkramApi::Client.new('simonneutert')
      response = client.expense_vouchers.all(order_direction: 'desc', order_by: 'id')
      response_body = response.body

      assert_equal(200, response.status)
      assert_operator(response_body['entries'].first['id'], :>, response_body['entries'].last['id'])
      assert_operator(response_body['entries'].first['id'], :>, response_body['entries'][1]['id'])
      refute_empty(response_body)
    end

    it 'gets all expense vouchers ordered by id asc', :vcr do
      client = PapierkramApi::Client.new('simonneutert')
      response = client.expense_vouchers.all(order_direction: 'asc', order_by: 'id')
      response_body = response.body

      assert_equal(200, response.status)
      assert_operator(response_body['entries'].first['id'], :<, response_body['entries'].last['id'])
      assert_operator(response_body['entries'].first['id'], :<, response_body['entries'][1]['id'])
      refute_empty(response_body)
    end

    it 'creates an expense voucher', :vcr do
      client = PapierkramApi::Client.new('simonneutert')
      response = client.expense_vouchers.create(
        name: 'Restaurant visit',
        due_date: '2020-06-30',
        document_date: '2020-06-14',
        description: 'Took customer for dinner.',
        entertainment_reason: 'sales meeting',
        flagged: true,
        provenance: 'domestic',
        entertainment_persons: [
          'Carl Customer'
        ],
        creditor_id: 9,
        line_items: [
          {
            amount: 150.8,
            name: 'restaurant bill',
            vat_rate: 0.19,
            category: 'Bewirtungskosten'
          },
          {
            amount: 15,
            name: 'tip',
            vat_rate: 0.19,
            category: 'Bewirtungskosten'
          }
        ]
      )

      response_body = response.body

      assert_equal(201, response.status)
      refute_empty(response_body)
    end

    it 'creates and deletes an expense voucher', :vcr do
      client = PapierkramApi::Client.new('simonneutert')
      response = client.expense_vouchers.create(
        name: 'Restaurant visit',
        due_date: '2020-06-30',
        document_date: '2020-06-14',
        description: 'Took customer for dinner.',
        entertainment_reason: 'sales meeting',
        flagged: true,
        provenance: 'domestic',
        entertainment_persons: [
          'Carl Customer'
        ],
        creditor_id: 9,
        line_items: [
          {
            amount: 150.8,
            name: 'restaurant bill',
            vat_rate: 0.19,
            category: 'Bewirtungskosten'
          },
          {
            amount: 15,
            name: 'tip',
            vat_rate: 0.19,
            category: 'Bewirtungskosten'
          }
        ]
      )

      response_body = response.body

      assert_equal(201, response.status)
      refute_empty(response_body)

      # deletion
      response = client.expense_vouchers.delete_by(id: response_body['id'])

      assert_equal(204, response.status)
    end

    it 'creates pays and cancels an expense voucher with reverse entry', :vcr do
      client = PapierkramApi::Client.new('simonneutert')
      response = client.expense_vouchers.create(
        name: 'Restaurant visit',
        due_date: '2020-06-30',
        document_date: '2020-06-14',
        description: 'Took customer for dinner.',
        entertainment_reason: 'sales meeting',
        flagged: true,
        provenance: 'domestic',
        entertainment_persons: [
          'Carl Customer'
        ],
        creditor_id: 9,
        line_items: [
          {
            amount: 150.8,
            name: 'restaurant bill',
            vat_rate: 0.19,
            category: 'Bewirtungskosten'
          },
          {
            amount: 15,
            name: 'tip',
            vat_rate: 0.19,
            category: 'Bewirtungskosten'
          }
        ]
      )

      response_body = response.body

      assert_equal(201, response.status)
      refute_empty(response_body)

      new_voucher_id = response_body['id']
      # deletion
      response = client.expense_vouchers.mark_as_paid_by(
        id: new_voucher_id,
        value: 165.80
      )

      assert_equal(200, response.status)

      response = client.expense_vouchers.cancel_with_reverse_entry_by(
        id: new_voucher_id
      )

      assert_equal(200, response.status)
    end

    it 'updates an expense voucher', :vcr do
      client = PapierkramApi::Client.new('simonneutert')
      response = client.expense_vouchers.update_by(
        id: 3,
        name: 'Restaurant lecker Essen essen'
      )
      response_body = response.body

      assert_equal(200, response.status)
      refute_empty(response_body)
    end

    it 'uploads a document to an expense voucher', :vcr do
      client = PapierkramApi::Client.new('simonneutert')
      response = client.expense_vouchers.add_document_by(
        id: 3,
        path_to_file: './test/files/YES.pdf',
        file_type: 'application/pdf'
      )

      response_body = response.body

      assert_equal(201, response.status)
      refute_empty(response_body)
    end

    it 'deletes a document from an expense voucher', :vcr do
      client = PapierkramApi::Client.new('simonneutert')
      response = client.expense_vouchers.delete_document_by(
        id: 3,
        document_id: 3
      )

      assert_equal(204, response.status)
    end

    it 'pays an expense voucher', :vcr do
      client = PapierkramApi::Client.new('simonneutert')
      response = client.expense_vouchers.mark_as_paid_by(
        id: 3,
        payment_date: '2024-01-12',
        value: 165.80
      )
      response_body = response.body

      assert_equal(200, response.status)
      refute_empty(response_body)

      assert_equal(
        { 'type' => 'expense_voucher',
          'id' => 3,
          'name' => 'Restaurant lecker Essen essen',
          'due_date' => '2020-06-30',
          'document_date' => '2020-06-14',
          'description' => 'Took customer for dinner.',
          'entertainment_reason' => 'sales meeting',
          'flagged' => true, 'provenance' => 'domestic',
          'voucher_no' => 'B-00001',
          'state' => 'unpaid',
          'record_state' => 'active',
          'amount' => 165.8,
          'invoice_amount' => 0.0,
          'entertainment_persons' => ['Carl Customer'],
          'creditor' => {
            'type' => 'company',
            'id' => 9,
            'name' => 'Luzy Katze',
            'contact_type' => 'supplier',
            'supplier_no' => 'L-00001',
            'customer_no' => nil,
            'email' => nil,
            'phone' => '<PHONE>',
            'website' => '',
            'twitter' => '',
            'fax' => '<FAX>',
            'postal_street' => nil,
            'postal_zip' => nil,
            'postal_city' => nil,
            'postal_country' => 'Deutschland',
            'physical_street' => nil,
            'physical_zip' => nil,
            'physical_city' => nil,
            'physical_country' => 'Deutschland',
            'delivery_method' => 'pdf',
            'ust_idnr' => '',
            'logo_file_name' => nil,
            'logo_content_type' => nil,
            'logo_file_size' => nil,
            'logo_updated_at' => nil,
            'bank_blz' => '<BLZ>',
            'bank_institute' => '',
            'bank_account_no' => '<ACCOUNT_NO>',
            'bank_bic' => '<BIC>',
            'bank_sepa_mandate_reference' => 'SEPAMRL00001LK',
            'bank_sepa_mandate_accepted' => nil,
            'bank_iban' => '<IBAN>',
            'inbound_address' => '456z',
            'notes' => '',
            'record_state' => 'active',
            'flagged' => nil,
            'created_at' => '2024-01-11T20:22:21.000+01:00',
            'updated_at' => '2024-01-11T20:22:21.000+01:00',
            'color' => 'blue'
          },
          'line_items' => [
            {
              'name' => 'restaurant bill',
              'amount' => 150.8,
              'category' => 'Bewirtungskosten',
              'vat_rate' => '19%',
              'billing' => nil,
              'depreciation' => nil
            },
            {
              'name' => 'tip',
              'amount' => 15.0,
              'category' => 'Bewirtungskosten',
              'vat_rate' => '19%',
              'billing' => nil,
              'depreciation' => nil
            }
          ],
          'documents' => [] }, response_body
      )
    end

    it 'cancels an expense voucher', :vcr do
      client = PapierkramApi::Client.new('simonneutert')
      response = client.expense_vouchers.cancel_by(id: 3)

      assert_equal(200, response.status)

      response_body = response.body

      refute_empty(response_body)
    end

    it 'archives an expense voucher', :vcr do
      client = PapierkramApi::Client.new('simonneutert')
      response = client.expense_vouchers.archive_by(id: 3)
      response_body = response.body

      assert_equal(200, response.status)
      refute_empty(response_body)
    end

    it 'unarchives an expense voucher', :vcr do
      client = PapierkramApi::Client.new('simonneutert')
      response = client.expense_vouchers.unarchive_by(id: 3)
      response_body = response.body

      assert_equal(200, response.status)
      refute_empty(response_body)
    end
  end
end
