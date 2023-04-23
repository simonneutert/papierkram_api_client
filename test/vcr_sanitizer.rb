# frozen_string_literal: true

# Provides the code to sanitize the VCR cassettes.
class VcrSanitizer
  class << self
    def sanitize(hash, k, _v) # rubocop:disable Metrics/PerceivedComplexity, Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Naming/MethodParameterName
      if hash['type'] == 'banking_transaction'
        hash[k] = '<USAGE>' if k == 'usage'
        hash[k] = '<PURPOSE>' if k == 'purpose'
        hash[k] = '<VALUE>' if k == 'value'
      end

      hash['from']['name'] = '<NAME>' if hash.dig('from', 'name')
      hash['saldo']['value'] = '<VALUE>' if hash.dig('saldo', 'value')

      if k == 'email' || k.include?('_email')
        hash[k] = '<EMAIL>'
      elsif k == 'sent_to' || k.include?('_sent_to')
        hash[k] = '<SENT_TO>'
      elsif k == 'blz' || k.include?('_blz')
        hash[k] = '<BLZ>'
      elsif k == 'bic' || k.include?('_bic')
        hash[k] = '<BIC>'
      elsif k == 'iban' || k.include?('_iban')
        hash[k] = '<IBAN>'
      elsif k == 'account_number' || k.include?('_account_number')
        hash[k] = '<ACCOUNT_NUMBER>'
      elsif k == 'account_no' || k.include?('_account_no')
        hash[k] = '<ACCOUNT_NO>'
      elsif k == 'phone' || k.include?('_phone')
        hash[k] = '<PHONE>'
      elsif k == 'mobile' || k.include?('_mobile')
        hash[k] = '<MOBILE>'
      elsif k == 'fax' || k.include?('_fax')
        hash[k] = '<FAX>'
      elsif k == 'lastname' || k.include?('_lastname')
        hash[k] = '<NAME>'
      elsif k == 'full_name' || k.include?('_full_name')
        hash[k] = '<FULL_NAME>'
      end
    end

    private

    def sub_key_value_sanitizing(hash, parent_key, sub_key, replacement_string = nil)
      replacement_string = "<#{sub_key.upcase}>" if replacement_string.nil?
      hash[parent_key][sub_key] = replacement_string if hash.dig(parent_key, sub_key)
    end
  end
end
