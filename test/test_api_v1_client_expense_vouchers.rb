# frozen_string_literal: true

require 'test_helper'

class TestExpenseVouchers < Minitest::Test
  describe 'ExpenseVouchers Requests' do
    it 'gets a single expense voucher', :vcr do
      client = PapierkramApi::Client.new('simonneutert')
      response = client.expense_vouchers.by(id: 650)
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
      assert(response_body['entries'].first['id'] > response_body['entries'].last['id'])
      assert(response_body['entries'].first['id'] > response_body['entries'][1]['id'])
      refute_empty(response_body)
    end

    it 'gets all expense vouchers ordered by id asc', :vcr do
      client = PapierkramApi::Client.new('simonneutert')
      response = client.expense_vouchers.all(order_direction: 'asc', order_by: 'id')
      response_body = response.body

      assert_equal(200, response.status)
      assert(response_body['entries'].first['id'] < response_body['entries'].last['id'])
      assert(response_body['entries'].first['id'] < response_body['entries'][1]['id'])
      refute_empty(response_body)
    end
  end
end
