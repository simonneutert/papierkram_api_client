# frozen_string_literal: true

require 'test_helper'

class TestValidatorsExpenseVoucher < Minitest::Test
  describe 'Expense::Voucher Validators' do
    it 'validates structe in sample is valid', :vcr do
      client = PapierkramApi::Client.new('simonneutert')
      res_all_page1 = client.expense_vouchers.all(page: 1, page_size: 10)

      assert_equal(200, res_all_page1.status)

      res_voucher = client.expense_vouchers.find_by(id: res_all_page1.body['entries'].first['id'])

      assert_equal(200, res_voucher.status)

      voucher = res_voucher.body

      assert(PapierkramApi::V1::Validators::ExpenseVoucher.new.validate!(voucher))
    end
  end
end
