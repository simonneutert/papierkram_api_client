# frozen_string_literal: true

module PapierkramApi
  module V1
    module BusinessIntelligence
      # Business Intelligence Base Class
      #
      # Business Intelligence is a set of services that can be used to gain
      # insights into the data stored in the system.
      #
      # Therefor you should pass data to the service and get back a result.
      #
      # IMPORTANT no calls to the API should be made in this class.
      # This is an intentional design decision! To seperate logic from the data source.
      #
      class Base
        def expenses_by_category
          warning = <<~MSG
            [DEPRECATION] `expenses_by_category` is deprecated.#{' '}
            It will be removed in a version after 0.4.0, most probably in 0.5.0.
          MSG
          warn(warning)

          @expenses_by_category ||= PapierkramApi::V1::BusinessIntelligence::ExpensesByCategory.new
        end
      end
    end
  end
end
