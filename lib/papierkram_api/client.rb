# frozen_string_literal: true

module PapierkramApi
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
      @subdomain = subdomain || ENV.fetch('PAPIERKRAM_API_SUBDOMAIN', nil)
      @api_key = api_key || ENV.fetch('PAPIERKRAM_API_KEY', nil)
      @base_url = base_url_env
      @remaining_quota = nil
      build_client!
    end

    def build_client!
      @client = Faraday.new(url: @base_url) do |config|
        config.request :authorization, 'Bearer', @api_key
        config.request :multipart
        config.request :json
        config.response :json

        config.adapter :httpx
        yield(config) if block_given?
      end
    end

    def banking_bank_connections
      @banking_bank_connections ||=
        PapierkramApi::V1::Endpoints::Banking::BankConnections.new(@client)
    end

    def banking_transactions
      @banking_transactions ||=
        PapierkramApi::V1::Endpoints::Banking::Transactions.new(@client)
    end

    def contact_companies
      @contact_companies ||=
        PapierkramApi::V1::Endpoints::Contact::Companies.new(@client)
    end

    def contact_companies_persons
      @contact_companies_persons ||=
        PapierkramApi::V1::Endpoints::Contact::CompaniesPersons.new(@client)
    end

    def expense_vouchers
      @expense_vouchers ||=
        PapierkramApi::V1::Endpoints::Expense::Vouchers.new(@client)
    end

    def income_estimates
      @income_estimates ||=
        PapierkramApi::V1::Endpoints::Income::Estimates.new(@client)
    end

    def income_invoices
      @income_invoices ||=
        PapierkramApi::V1::Endpoints::Income::Invoices.new(@client)
    end

    def income_payment_terms
      @income_payment_terms ||=
        PapierkramApi::V1::Endpoints::Income::PaymentTerms.new(@client)
    end

    def income_propositions
      @income_propositions ||=
        PapierkramApi::V1::Endpoints::Income::Propositions.new(@client)
    end

    def info
      @info ||=
        PapierkramApi::V1::Endpoints::Info.new(@client)
    end

    def projects
      @projects ||=
        PapierkramApi::V1::Endpoints::Projects.new(@client)
    end

    def tracker_tasks
      @tracker_tasks ||=
        PapierkramApi::V1::Endpoints::Tracker::Tasks.new(@client)
    end

    def tracker_time_entries
      @tracker_time_entries ||=
        PapierkramApi::V1::Endpoints::Tracker::TimeEntries.new(@client)
    end

    private

    def base_url_env
      return 'http://localhost:3000' if ENV.fetch('DEBUG_LOCALHOST', false).to_s == 'true'

      "https://#{@subdomain}.papierkram.de"
    end
  end
end
