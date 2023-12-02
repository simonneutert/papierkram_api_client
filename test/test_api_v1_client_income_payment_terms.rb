# frozen_string_literal: true

require 'test_helper'

class TestIncomePaymentTerms < Minitest::Test
  describe 'Income::PaymentTerms Requests' do
    it 'gets a single income payment_term', :vcr do
      client = PapierkramApi::Client.new('simonneutert')
      response = client.income_payment_terms.find_by(id: 3)
      response_body = response.body

      assert_equal 200, response.status

      assert_equal(%w[type
                      id
                      name
                      cash_discount
                      cash_discount_time
                      cash_discount_unit
                      due_time
                      due_time_unit
                      number_reminders
                      number_dunnings
                      dunning_fee
                      created_at
                      updated_at
                      template
                      default_template
                      template_id
                      default_reminder_template
                      template_text
                      payment_required
                      banking_bank_connection].sort, response_body.keys.sort)

      assert_equal 'payment_term', response_body['type']
      assert_equal 3, response_body['id']
      assert_equal '10 Tage Zahlungsfrist', response_body['name']
      assert_nil response_body['cash_discount']
      assert_nil response_body['cash_discount_time']
      assert_nil response_body['cash_discount_unit']
      assert_equal 10, response_body['due_time']
      assert_equal 'day', response_body['due_time_unit']
      assert_nil response_body['number_reminders']
      assert_nil response_body['number_dunnings']
      assert_nil response_body['dunning_fee']
      assert_equal '2018-03-06T15:55:56.000+01:00', response_body['created_at']
      assert_equal '2018-03-06T15:55:56.000+01:00', response_body['updated_at']
      assert response_body['template']
      refute(response_body['default_template'])
      assert_nil response_body['template_id']
      refute(response_body['default_reminder_template'])
      assert_nil response_body['template_text']
      assert(response_body['payment_required'])
    end

    it 'get all income payment_terms paginated', :vcr do
      client = PapierkramApi::Client.new('simonneutert')
      response = client.income_payment_terms.all
      response_body = response.body

      assert_equal 200, response.status
      assert_equal %w[entries
                      has_more
                      page
                      page_size
                      total_entries
                      total_pages
                      type].sort, response_body.keys.sort
      assert_equal 1, response_body['page']
      assert_equal 100, response_body['page_size']
      assert_equal 1, response_body['total_pages']
      assert_equal 21, response_body['total_entries']
      assert response_body['has_more'].is_a?(FalseClass)
      assert_equal 'list', response_body['type']
      assert response_body['entries'].is_a?(Array)
      assert_equal 21, response_body['entries'].length

      first_entry = response_body['entries'].first

      assert_equal %w[type
                      id
                      name
                      cash_discount
                      cash_discount_time
                      cash_discount_unit
                      due_time
                      due_time_unit
                      number_reminders
                      number_dunnings
                      dunning_fee
                      created_at
                      updated_at
                      template
                      default_template
                      template_id
                      default_reminder_template
                      template_text
                      payment_required].sort, first_entry.keys.sort

      assert_equal 'payment_term', first_entry['type']
      assert_equal 3, first_entry['id']
      assert_equal '10 Tage Zahlungsfrist', first_entry['name']
      assert_nil first_entry['cash_discount']
      assert_nil first_entry['cash_discount_time']
      assert_nil first_entry['cash_discount_unit']
      assert_equal 10, first_entry['due_time']
      assert_equal 'day', first_entry['due_time_unit']
      assert_nil first_entry['number_reminders']
      assert_nil first_entry['number_dunnings']
      assert_nil first_entry['dunning_fee']
      assert_equal '2018-03-06T15:55:56.000+01:00', first_entry['created_at']
      assert_equal '2018-03-06T15:55:56.000+01:00', first_entry['updated_at']
      assert first_entry['template']
      refute(first_entry['default_template'])
      assert_nil first_entry['template_id']
      refute(first_entry['default_reminder_template'])
      assert_nil first_entry['template_text']
      assert(first_entry['payment_required'])

      last_entry = response_body['entries'].last

      assert_equal 'payment_term', last_entry['type']
      assert_equal 6, last_entry['id']
      assert_equal '10 Arbeitstage Zahlungsfrist', last_entry['name']
      assert_nil last_entry['cash_discount']
      assert_nil last_entry['cash_discount_time']
      assert_nil last_entry['cash_discount_unit']
      assert_equal 10, last_entry['due_time']
      assert_equal 'work_day', last_entry['due_time_unit']
      assert_nil last_entry['number_reminders']
      assert_nil last_entry['number_dunnings']
      assert_nil last_entry['dunning_fee']
      assert_equal '2018-03-06T15:55:56.000+01:00', last_entry['created_at']
      assert_equal '2018-03-06T15:55:56.000+01:00', last_entry['updated_at']
      assert last_entry['template']
      refute(last_entry['default_template'])
      assert_nil last_entry['template_id']
      refute(last_entry['default_reminder_template'])
      assert_nil last_entry['template_text']
      assert(last_entry['payment_required'])
    end
  end
end
