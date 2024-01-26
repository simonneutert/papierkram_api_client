# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'papierkram_api_client'
require 'minitest/autorun'
require 'minispec-metadata'
require 'minitest/spec'
require 'minitest-vcr'
require 'webmock'
require 'faraday'
require 'vcr'
require 'pry'
require 'uri'

require_relative 'vcr_sanitizer'

def iterate_throgh_hash(hash, &block) # rubocop:disable Metrics/CyclomaticComplexity
  hash.each do |k, v|
    iterate_throgh_hash(v, &block) if v.is_a?(Hash)
    v.each { |elem| iterate_throgh_hash(elem, &block) } if v.is_a?(Array) && v.first.is_a?(Hash)

    next unless k.is_a?(String)
    next unless hash[k]

    yield(hash, k, v)
  end
end

VCR.configure do |c|
  c.cassette_library_dir = 'test/cassettes'
  c.hook_into :faraday
  c.allow_http_connections_when_no_cassette = false

  c.filter_sensitive_data('<API BEARER>') { ENV.fetch('PAPIERKRAM_API_KEY', nil) }
  c.filter_sensitive_data('<UNICORN>') do |interaction|
    next unless interaction.response.headers['set-cookie']

    interaction.response.headers['set-cookie'].first.split(';').first.split('=').last
  end
  c.before_record do |interaction|
    interaction.response.body.scan(/\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}\b/).each do |email|
      interaction.response.body.gsub!(email, '<EMAIL>')
    end

    json_body = begin
      JSON.parse(interaction.response.body)
    rescue JSON::ParserError => e
      puts e
      {}
    end

    # auto sanitize by key in json body
    iterate_throgh_hash(json_body) do |hash, k, v|
      VcrSanitizer.sanitize(hash, k, v)
    end

    interaction.response.body = json_body.to_json
  end
  # c.filter_sensitive_data('<DOMAIN>') { ENV.fetch('PAPIERKRAM_API_SUBDOMAIN', nil) }
  # c.filter_sensitive_data('<DOMAIN>') { 'http://localhost:3000/' }
end

MinitestVcr::Spec.configure!
