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
  end
end
