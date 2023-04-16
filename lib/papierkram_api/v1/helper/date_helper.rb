# frozen_string_literal: true

module PapierkramApi
  module V1
    module Helper
      # Helper module for date related methods
      module DateHelper
        def build_date_string_for_api(date)
          date.strftime('%Y-%m-%d')
        end
      end
    end
  end
end
