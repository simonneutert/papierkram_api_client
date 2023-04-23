# frozen_string_literal: true

module PapierkramApi
  module V1
    module BusinessIntelligence
      # Business Intelligence for Expenses
      class ExpensesByCategory
        #
        # Calculate the expenses by category
        #
        # @param [Array<Hash>] expense_vouchers represents a list of expense vouchers in the format:
        #
        # @param [<Type>] &block <description>
        #
        # @return [<Type>] <description>
        #
        def call(expense_vouchers:, &block)
          return {} if expense_vouchers.is_a?(Array) && expense_vouchers.empty?

          validate_expense_vouchers!(expense_vouchers)
          return results(expense_vouchers, &block) if block

          results(expense_vouchers)
        end

        private

        def results(expense_vouchers)
          coll = prepare_voucher_data(expense_vouchers)
          coll = yield(coll) if block_given?
          line_items_grouped_by_category = coll.group_by { |v| v['category'] }
          sum_categories!(line_items_grouped_by_category)
        end

        def sum_categories!(line_items_grouped_by_category)
          lookup_table = {}
          line_items_grouped_by_category.each do |category_name, line_items|
            line_items_by_creditor_lot = {}
            line_items_by_creditor = line_items.group_by { |v| v['creditor'] }
            sum_up_creditor!(line_items_by_creditor, line_items_by_creditor_lot)
            build_result_lookup_table!(lookup_table, category_name, line_items, line_items_by_creditor_lot)
          end
          lookup_table
        end

        def sum_up_creditor!(line_items_by_creditor, line_items_by_creditor_lot)
          line_items_by_creditor.each do |category_name, line_items|
            line_items_by_creditor_lot[category_name] = line_items.reduce(0) do |sum, creditor|
              sum + creditor['amount']
            end
          end
          line_items_by_creditor_lot
        end

        def build_result_lookup_table!(lookup_table, category_name, line_items, line_items_by_creditor_lot)
          lookup_table[category_name] = {
            'amount' => line_items.reduce(0) { |sum, line_item| sum + line_item['amount'] },
            'amount_by_creditor' => line_items_by_creditor_lot,
            'line_items' => line_items
          }
        end

        def prepare_voucher_data(vouchers)
          coll = []
          vouchers.flat_map do |voucher|
            voucher['line_items'].each do |line_item|
              res = line_item.merge(
                { 'voucher_name' => voucher['name'] },
                { 'voucher_id' => voucher['id'] },
                'creditor' => voucher['creditor']
              )
              coll.push(res)
            end
          end
          coll
        end

        # TODO: move to a validator class forPapierkramApi::V1::Validators::ExpenseVouchers
        def validate_expense_vouchers!(expense_vouchers)
          raise ArgumentError, 'expense_vouchers must be an Array' unless expense_vouchers.is_a?(Array)
          raise ArgumentError, 'expense_vouchers must not be empty' if expense_vouchers.empty?
          raise ArgumentError, 'expense_vouchers must contain Hashes' unless expense_vouchers.all?(Hash)

          validator = PapierkramApi::V1::Validators::ExpenseVoucher.new
          expense_vouchers.all? do |voucher|
            validate_expense_voucher!(validator, voucher)
          end
        end

        def validate_expense_voucher!(validator, expense_voucher)
          validator.validate!(expense_voucher)
        end
      end
    end
  end
end
