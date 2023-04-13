# frozen_string_literal: true

require 'faraday'
require 'httpx/adapters/faraday'
require 'forwardable'
require 'tempfile'

require_relative 'papierkram_api_client/version'
require_relative 'api/v1/base'
require_relative 'api/v1/banking/bank_connections'
require_relative 'api/v1/banking/transactions'
require_relative 'api/v1/contact/companies'
require_relative 'api/v1/contact/companies_persons'
require_relative 'api/v1/expense/vouchers'
require_relative 'api/v1/income/estimates'
require_relative 'api/v1/income/invoices'
require_relative 'api/v1/income/propositions'
require_relative 'api/v1/info'
require_relative 'api/v1/projects'
require_relative 'api/v1/tracker/tasks'
require_relative 'api/v1/tracker/time_entries'

module PapierkramApiClient
  class Error < StandardError; end

  # The Client class is the main entry point for the Papierkram API Client.
  class Client
    attr_accessor :client,
                  :subdomain,
                  :api_key,
                  :base_url,
                  :remaining_quota

    extend Forwardable
    def_delegators :@client, :get, :post, :put, :patch, :delete

    def initialize(subdomain = nil, api_key = nil)
      @subdomain = subdomain || ENV.fetch('PAPIERKRAM_SUBDOMAIN', nil)
      @api_key = api_key || ENV.fetch('PAPIERKRAM_API_KEY', nil)
      @base_url = base_url_env
      @remaining_quota = nil
      build_client!
    end

    def build_client!
      @client = Faraday.new(url: @base_url) do |config|
        config.request :authorization, 'Bearer', @api_key
        config.request :json
        config.response :json
        config.adapter :httpx
        yield(config) if block_given?
      end
    end

    def banking_bank_connections
      @banking_bank_connections ||= Api::V1::Banking::BankConnections.new(@client)
    end

    def banking_transactions
      raise ArgumentError, 'not implemented'
      # @banking_transactions ||= Api::V1::Banking::Transactions.new(@client)
    end

    def contact_companies
      @contact_companies ||= Api::V1::Contact::Companies.new(@client)
    end

    def contact_companies_persons
      @contact_companies_persons ||= Api::V1::Contact::CompaniesPersons.new(@client)
    end

    def expense_vouchers
      @expense_vouchers ||= Api::V1::Expense::Vouchers.new(@client)
    end

    def income_estimates
      @income_estimates ||= Api::V1::Income::Estimates.new(@client)
    end

    def income_invoices
      @income_invoices ||= Api::V1::Income::Invoices.new(@client)
    end

    def income_propositions
      @income_propositions ||= Api::V1::Income::Propositions.new(@client)
    end

    def info
      @info ||= Api::V1::Info.new(@client)
    end

    def projects
      @projects ||= Api::V1::Projects.new(@client)
    end

    def tracker_tasks
      @tracker_tasks ||= Api::V1::Tracker::Tasks.new(@client)
    end

    def tracker_time_entries
      @tracker_time_entries ||= Api::V1::Tracker::TimeEntries.new(@client)
    end

    private

    def base_url_env
      "https://#{@subdomain}.papierkram.de"
    end
  end
end
