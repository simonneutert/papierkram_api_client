# frozen_string_literal: true

require 'test_helper'

class TestPapierkramApiClient < Minitest::Test
  describe 'PaperkramApi::Client for local development via ENV DEBUG_LOCALHOST' do
    before do
      @debug_localhost_before = ENV['DEBUG_LOCALHOST'].dup
      ENV['DEBUG_LOCALHOST'] = 'true'
      @client = PapierkramApi::Client.new('simonneutert')
    end

    after do
      ENV['DEBUG_LOCALHOST'] = @debug_localhost_before
    end

    it 'must equal localhost:3000' do
      _(@client.send(:base_url_env)).must_equal('http://localhost:3000')
    end
  end
end
