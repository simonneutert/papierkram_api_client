# frozen_string_literal: true

require 'test_helper'

class TestBusinessIntelligenceExpenses < Minitest::Test
  describe 'Business Intelligence Expenses Requests' do
    it 'categorizes expenses by category', :vcr do
      client = PapierkramApi::Client.new('simonneutert')
      expense_vouchers_api = client.expense_vouchers
      expense_voucher_data_service =
        PapierkramApi::V1::BusinessIntelligence::SmartQueries::ExpenseVouchersForMonthInYear.new(expense_vouchers_api)
      expense_vouchers_in_date_range = expense_voucher_data_service.for_month_in_year(year: 2020, month: 8)

      service = client.business_intelligence.expenses_by_category
      result = service.call(expense_vouchers: expense_vouchers_in_date_range)

      assert_kind_of(Hash, result)
      assert(result.keys.all?(String))
      assert(result.values.all?(Hash))

      assert(result[result.keys.first].keys.all?(String))
      assert_includes(result[result.keys.first].keys, 'amount')
      assert_includes(result[result.keys.first].keys, 'amount_by_creditor')
      assert_kind_of(Float, result[result.keys.first]['amount'])
      refute_empty(result)
    end

    it 'categorizes expenses by category filter example', :vcr do
      client = PapierkramApi::Client.new('simonneutert')
      expense_vouchers_api = client.expense_vouchers
      expense_voucher_data_service =
        PapierkramApi::V1::BusinessIntelligence::SmartQueries::ExpenseVouchersForMonthInYear.new(expense_vouchers_api)
      expense_vouchers_in_date_range = expense_voucher_data_service.for_month_in_year(year: 2020, month: 8)

      service = client.business_intelligence.expenses_by_category
      result = service.call(expense_vouchers: expense_vouchers_in_date_range) do |line_items|
        line_items.select { |v| v['vat_rate'] == '19%' }
      end

      assert_kind_of(Hash, result)
      assert(result.keys.all?(String))
      assert(result.values.all?(Hash))
      refute_empty(result)
    end
  end
end
