# frozen_string_literal: true

require 'test_helper'

class TestTrackerTasks < Minitest::Test
  describe 'Tracker::Tasks Requests' do
    it 'gets a tracker tasks', :vcr do
      client = PapierkramApi::Client.new('simonneutert')
      response = client.tracker_tasks.find_by(id: 1)
      response_body = response.body

      assert_equal(200, response.status)
      refute_empty(response_body)
    end

    it 'get all tracker tasks', :vcr do
      client = PapierkramApi::Client.new('simonneutert')
      response = client.tracker_tasks.all
      response_body = response.body

      assert_equal(200, response.status)
      refute_empty(response_body)
    end

    it 'creates a tracker tasks', :vcr do
      client = PapierkramApi::Client.new('simonneutert')
      response = client.tracker_tasks.create(name: 'Test Tracker Task', project_id: 9, proposition_id: 6)
      response_body = response.body

      assert_equal(201, response.status)
      refute_empty(response_body)

      assert_equal('task', response_body['type'])
      assert_equal(3, response_body['id'])
      assert_equal('Test Tracker Task', response_body['name'])
      assert_equal(9, response_body['project_id'])
      assert_nil(response_body['relative_costs'])
      assert_nil(response_body['complete'])
      assert_nil(response_body['deadline'])
      assert_nil(response_body['flagged'])
      assert_equal('active', response_body['record_state'])
      assert_equal('2023-12-02T20:59:29.000+01:00', response_body['created_at'])
      assert_equal('2023-12-02T20:59:29.000+01:00', response_body['updated_at'])

      assert_equal('project', response_body['project']['type'])
      assert_equal(9, response_body['project']['id'])
      assert_equal('Test Project', response_body['project']['name'])
      assert_nil(response_body['project']['description'])
      assert_equal('2020-01-01', response_body['project']['start_date'])
      assert_equal('2020-12-31', response_body['project']['end_date'])
      assert_nil(response_body['project']['flagged'])
      assert_nil(response_body['project']['budget_type'])
      assert_nil(response_body['project']['budget_money'])
      assert_nil(response_body['project']['budget_time'])
      assert_nil(response_body['project']['budget_time_unit'])
      refute(response_body['project']['customer_default'])
      assert_equal('active', response_body['project']['record_state'])
      assert_equal('2023-06-28T20:17:59.000+02:00', response_body['project']['created_at'])
      assert_equal('2023-12-02T20:59:29.000+01:00', response_body['project']['updated_at'])
      assert_equal(3, response_body['project']['company_id'])
      assert_nil(response_body['project']['color'])

      assert_equal('proposition', response_body['proposition']['type'])
      assert_equal(6, response_body['proposition']['id'])
      assert_equal('Software design', response_body['proposition']['name'])
      assert_equal('123456', response_body['proposition']['article_no'])
      assert_equal('service', response_body['proposition']['proposition_type'])
      assert_equal('Here, we can describe what "Software design" actually entails.',
                   response_body['proposition']['description'])
      assert_equal('150.0', response_body['proposition']['price'])
      assert_equal('hour', response_body['proposition']['time_unit'])
      assert_equal('Stunde', response_body['proposition']['unit_name_1'])
      assert_equal('Stunden', response_body['proposition']['unit_name_n'])
      assert_equal('active', response_body['proposition']['record_state'])
      assert_nil(response_body['proposition']['flagged'])
      assert_nil(response_body['proposition']['favorite'])
      assert_equal('2023-06-30T09:38:31.000+02:00', response_body['proposition']['created_at'])
      assert_equal('2023-06-30T09:39:40.000+02:00', response_body['proposition']['updated_at'])

      assert_nil(response_body['user'])
    end

    it 'updates a tracker tasks', :vcr do
      client = PapierkramApi::Client.new('simonneutert')
      response = client.tracker_tasks.update_by(id: 3, name: 'Test Tracker Taski', project_id: 9, proposition_id: 6)
      response_body = response.body

      assert_equal(200, response.status)
      refute_empty(response_body)

      expected_response_body = {
        'type' => 'task',
        'id' => 3,
        'name' => 'Test Tracker Taski',
        'project_id' => 9,
        'relative_costs' => nil,
        'complete' => nil,
        'deadline' => nil,
        'flagged' => nil,
        'record_state' => 'active',
        'created_at' => '2023-12-02T20:59:29.000+01:00',
        'updated_at' => '2023-12-02T21:09:53.000+01:00',
        'project' => {
          'type' => 'project',
          'id' => 9,
          'name' => 'Test Project',
          'description' => nil,
          'start_date' => '2020-01-01',
          'end_date' => '2020-12-31',
          'flagged' => nil,
          'budget_type' => nil,
          'budget_money' => nil,
          'budget_time' => nil,
          'budget_time_unit' => nil,
          'customer_default' => false,
          'record_state' => 'active',
          'created_at' => '2023-06-28T20:17:59.000+02:00',
          'updated_at' => '2023-12-02T21:09:53.000+01:00',
          'company_id' => 3,
          'color' => nil
        },
        'proposition' => {
          'type' => 'proposition',
          'id' => 6,
          'name' => 'Software design',
          'article_no' => '123456',
          'proposition_type' => 'service',
          'description' => 'Here, we can describe what "Software design" actually entails.',
          'price' => '150.0',
          'time_unit' => 'hour',
          'unit_name_1' => 'Stunde',
          'unit_name_n' => 'Stunden',
          'record_state' => 'active',
          'flagged' => nil,
          'favorite' => nil,
          'created_at' => '2023-06-30T09:38:31.000+02:00',
          'updated_at' => '2023-06-30T09:39:40.000+02:00'
        },
        'user' => nil
      }

      assert_equal(expected_response_body, response_body)
    end
  end
end
