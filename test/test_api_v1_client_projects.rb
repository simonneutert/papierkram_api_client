# frozen_string_literal: true

require 'test_helper'

class TestProjects < Minitest::Test
  describe 'Project Requests' do
    it 'gets a project', :vcr do
      client = PapierkramApi::Client.new('simonneutert')
      response = client.projects.find_by(id: 5)
      response_body = response.body

      assert_equal(200, response.status)
      refute_empty(response_body)
    end

    it 'get all projects', :vcr do
      client = PapierkramApi::Client.new('simonneutert')
      response = client.projects.all
      response_body = response.body

      assert_equal(200, response.status)
      refute_empty(response_body)
    end

    it 'create a project', :vcr do
      client = PapierkramApi::Client.new('simonneutert')
      response = client.projects.create(
        name: 'Test Project',
        customer_id: 3,
        start_date: '2020-01-01',
        end_date: '2020-12-31'
      )

      assert_equal(201, response.status)
      assert_equal %w[
        budget_money
        budget_time
        budget_time_unit
        budget_type
        color
        company_id
        created_at
        customer
        customer_default
        default_proposition
        description
        end_date
        flagged
        id
        invoices
        name
        record_state
        start_date
        tasks
        team_members
        type
        updated_at
        vouchers
      ], response.body.keys.sort
      assert_equal('Test Project', response.body['name'])
      assert response.body['customer'].is_a?(Hash)
      assert_equal('company', response.body['customer']['type'])
      assert response.body['team_members'].is_a?(Array)
      assert response.body['tasks'].is_a?(Hash)
      assert_equal('list', response.body['tasks']['type'])
      assert response.body['tasks']['entries'].is_a?(Array)
      assert_includes response.body['tasks']['url'], 'api/v1/tracker/tasks?project_id'

      assert response.body['invoices'].is_a?(Hash)
      assert_equal('list', response.body['invoices']['type'])
      assert response.body['invoices']['entries'].is_a?(Array)
      assert_includes response.body['invoices']['url'], 'api/v1/income/invoices?project_id'

      assert response.body['vouchers'].is_a?(Hash)
      assert_equal('list', response.body['vouchers']['type'])
      assert response.body['vouchers']['entries'].is_a?(Array)
      assert_includes response.body['vouchers']['url'], 'api/v1/expense/vouchers?project_id'
    end

    it 'update a project', :vcr do
      client = PapierkramApi::Client.new('simonneutert')
      response = client.projects.update_by(
        id: 12,
        attributes: {
          name: 'Test Projecticles'
        }
      )

      assert_equal(200, response.status)

      assert_equal %w[
        budget_money
        budget_time
        budget_time_unit
        budget_type
        color
        company_id
        created_at
        customer
        customer_default
        default_proposition
        description
        end_date
        flagged
        id
        invoices
        name
        record_state
        start_date
        tasks
        team_members
        type
        updated_at
        vouchers
      ].sort, response.body.keys.sort

      assert_equal('Test Projecticles', response.body['name'])
      assert response.body['customer'].is_a?(Hash)
      assert_equal('company', response.body['customer']['type'])
      assert response.body['team_members'].is_a?(Array)
      assert response.body['tasks'].is_a?(Hash)
      assert_equal('list', response.body['tasks']['type'])
      assert response.body['tasks']['entries'].is_a?(Array)
      assert_includes response.body['tasks']['url'], 'api/v1/tracker/tasks?project_id'

      assert response.body['invoices'].is_a?(Hash)
      assert_equal('list', response.body['invoices']['type'])
      assert response.body['invoices']['entries'].is_a?(Array)
      assert_includes response.body['invoices']['url'], 'api/v1/income/invoices?project_id'

      assert response.body['vouchers'].is_a?(Hash)
      assert_equal('list', response.body['vouchers']['type'])
      assert response.body['vouchers']['entries'].is_a?(Array)
      assert_includes response.body['vouchers']['url'], 'api/v1/expense/vouchers?project_id'
    end

    it 'delete a project', :vcr do
      client = PapierkramApi::Client.new('simonneutert')
      response = client.projects.delete_by(id: 12)

      assert_equal(204, response.status)
    end

    it 'archive a project', :vcr do
      client = PapierkramApi::Client.new('simonneutert')
      response = client.projects.archive_by(id: 15)

      assert_equal(200, response.status)
    end

    it 'unarchive a project', :vcr do
      client = PapierkramApi::Client.new('simonneutert')
      response = client.projects.unarchive_by(id: 15)

      assert_equal(200, response.status)
    end
  end
end
