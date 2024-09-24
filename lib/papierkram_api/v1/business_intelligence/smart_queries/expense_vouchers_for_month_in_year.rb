# frozen_string_literal: true

module PapierkramApi
  module V1
    module BusinessIntelligence
      module SmartQueries
        # This class is responsible for all the API calls related to expense vouchers.
        class ExpenseVouchersForMonthInYear
          include PapierkramApi::V1::Helper::DateHelper

          def initialize(expense_voucher_api)
            @expense_voucher_api = expense_voucher_api
          end

          def for_month_in_year(year:, month:)
            @year = year
            @month = month
            @start_date = Date.new(@year, @month, 1)
            @end_date = Date.new(@year, @month + 1, 1) - 1
            collect_expense_vouchers
          end

          private

          def collect_expense_vouchers
            all_expense_vouchers_in_date_range.map do |voucher|
              @expense_voucher_api.find_by(id: voucher['id']).body
            end
          end

          def all_expense_vouchers_in_date_range
            page = 1
            res = expense_vouchers(page: page)
            vouchers = res.body['entries'].map { |v| v }
            while res.body['page'] != res.body['total_pages']
              res = expense_vouchers(page: page)
              res.body['entries'].each { |v| vouchers << v }
            end
            vouchers
          end

          def expense_vouchers(page: 1)
            @expense_voucher_api.all(
              page: page,
              document_date_range_start: build_date_string_for_api(@start_date),
              document_date_range_end: build_date_string_for_api(@end_date)
            )
          end

          def expense_voucher(id)
            @expense_voucher_api.find_by(id: id)
          end
        end
      end
    end
  end
end
