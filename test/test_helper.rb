# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'papierkram_api_client'
require 'minitest/autorun'
require 'vcr'
require 'minitest-vcr'
require 'pry'
require 'uri'

VCR.configure do |c|
  c.cassette_library_dir = 'test/cassettes'
  c.hook_into :faraday
  c.filter_sensitive_data('<API BEARER>') { ENV.fetch('PAPIERKRAM_API_KEY', nil) }
  c.filter_sensitive_data('<UNICORN>') do |interaction|
    interaction.response.headers['set-cookie'].first.split(';').first.split('=').last
  end
  c.before_record do |interaction|
    interaction.response.body.scan(/\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}\b/).each do |email|
      interaction.response.body.gsub!(email, '<EMAIL>')
    end
  end
  # c.filter_sensitive_data('<DOMAIN>') { ENV.fetch('PAPIERKRAM_SUBDOMAIN', nil) }
  # c.filter_sensitive_data('<DOMAIN>') { 'http://localhost:3000/' }
end

MinitestVcr::Spec.configure!
