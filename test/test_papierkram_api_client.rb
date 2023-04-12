# frozen_string_literal: true

require 'test_helper'
MinitestVcr::Spec.configure!

class TestPapierkramApiClient < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::PapierkramApiClient::VERSION
  end
end
