# frozen_string_literal: true

module PapierkramApi
  module V1
    module Validators
      # ExpenseVoucher Validator
      class ExpenseVoucher
        # Copied from https://simonneutert.papierkram.de/api/v1/api-docs/index.html
        SWAGGER_SAMPLE = {
          type: 'expense_voucher',
          id: 385,
          name: 'Restaurant visit',
          due_date: '2020-06-30',
          document_date: '2020-06-14',
          description: 'Took customer for dinner.',
          entertainment_reason: 'sales meeting',
          flagged: true,
          provenance: 'domestic',
          voucher_no: 'B-EXP-0001',
          state: 'unpaid',
          record_state: 'active',
          amount: 165.8,
          invoice_amount: 0,
          entertainment_persons: [],
          creditor: {
            type: 'company',
            id: 4814,
            name: 'Ristorante Il Porcino',
            contact_type: 'supplier',
            supplier_no: 'L-00001',
            customer_no: nil,
            email: nil,
            phone: nil,
            website: nil,
            twitter: nil,
            fax: nil,
            postal_street: 'Dotzheimer Str. 36',
            postal_zip: '65185',
            postal_city: 'Wiesbaden',
            postal_country: 'Deutschland',
            physical_street: nil,
            physical_zip: nil,
            physical_city: nil,
            physical_country: 'Deutschland',
            delivery_method: nil,
            ust_idnr: 'BE0999999999',
            logo_file_name: nil,
            logo_content_type: nil,
            logo_file_size: nil,
            logo_updated_at: nil,
            bank_blz: '79351010',
            bank_institute: 'Sparkasse Bad Kissingen',
            bank_account_no: '789456123',
            bank_bic: 'MARKDEFFXXX',
            bank_sepa_mandate_reference: 'SEPAMRL00001RIP',
            bank_sepa_mandate_accepted: nil,
            bank_iban: 'DE68210501700012345678',
            inbound_address: 'emkx',
            notes: nil,
            record_state: 'active',
            flagged: nil,
            created_at: '2023-04-04T10:14:16.000+02:00',
            updated_at: '2023-04-04T10:14:16.000+02:00',
            color: nil
          },
          line_items: [
            {
              name: 'restaurant bill',
              amount: 150.8,
              category: 'Bewirtungskosten',
              vat_rate: '19%',
              billing: nil,
              depreciation: nil
            },
            {
              name: 'tip',
              amount: 15,
              category: 'Bewirtungskosten',
              vat_rate: '19%',
              billing: nil,
              depreciation: nil
            }
          ],
          documents: [
            {
              type: 'document',
              id: 30,
              uri: 'http://test.odacer.com/system/attachments/1/documents/30/7e6274cdeac3ecfdd1e5c746f6378e5229ddfd0d/data/original/sample.pdf?1680596056'
            }
          ]
        }.freeze
        SWAGGER_SAMPLE_KEYS_STRINGIFIED = SWAGGER_SAMPLE.keys.map(&:to_s).sort.freeze

        def validate!(expense_voucher)
          unless expense_voucher['type'] == 'expense_voucher' &&
                 expense_voucher.keys.sort == SWAGGER_SAMPLE_KEYS_STRINGIFIED
            raise ArgumentError, 'expense_voucher does not match the expected format'
          end

          true
        end
      end
    end
  end
end
